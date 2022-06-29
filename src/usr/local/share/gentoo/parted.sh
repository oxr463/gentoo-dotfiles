#!/bin/sh
# Automatically partition disk drive
set -eu

# Depends on GNU parted
if ! command -v parted > /dev/null; then
  exit 125
fi

# Default disk unless specified
DISK="${1:-/dev/sda}"

# Partition ESP and rootfs
parted --script \
       --align optimal -- "${DISK}" \
       mklabel gpt \
       mkpart primary fat32 1MiB 513MiB \
       mkpart primary 514MiB -0 \
       set 1 boot on
