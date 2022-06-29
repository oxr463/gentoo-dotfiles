#!/bin/sh
# Configure logical volumes
set -eu

# Depends on LVM
for cmd in lvcreate pvcreate vgcreate; do
  if ! command -v "${cmd}" > /dev/null; then
    exit 125
  fi
done

# Assumes rootfs has been decrypted
ROOTFS="${1:-/dev/mapper/dmcrypt_rootfs}"

# Create physical volume
pvcreate "${ROOTFS}"

# Create volume group
vgcreate "${VG:=vg0}" "${ROOTFS}"

# Create logical volumes
lvcreate -L40G       --name root "${VG}"
lvcreate -L2G        --name swap "${VG}"
lvcreate -l 100%FREE --name home "${VG}"

