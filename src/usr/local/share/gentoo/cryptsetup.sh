#!/bin/sh
# Setup encrypted rootfs
set -eu

# Depends on dm-crypt
if ! command -v cryptsetup > /dev/null; then
  exit 125
fi

# Default rootfs unless specified
ROOTFS="/dev/${1:-sda2}"

# Optionally specify a key file
KEYFILE="${2:-$(pwd)/rootfs.key}"

# Predefine dm-crypt options
CRYPT_EXEC="cryptsetup --cipher aes-xts-plain64 \
                       --hash sha512 \
                       --key-size 256 \
		       --batch-mode \
                       luksFormat ${ROOTFS}"

# Fallback to key file if no password specified
if [ "${PASSWD:=!}" = "!" ]; then
  (dd if=/dev/urandom of="${KEYFILE}" bs=1 count=4096) > /dev/null 2>&1

  /bin/sh -c "${CRYPT_EXEC} ${KEYFILE}"
else
  /bin/sh -c "echo ${PASSWD} | ${CRYPT_EXEC} -"
fi

