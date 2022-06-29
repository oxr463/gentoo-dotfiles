#!/bin/sh
# Format partitions
set -eu

# Depends on the follwing:
for cmd in mkfs mkswap; do
  if ! command -v "${cmd}" > /dev/null; then
    exit 125
  fi
done

# Assumes volume group is available
VG="${1:-vg0}"

# Format EFI System Partition
mkfs.vfat "${ESP:=/dev/sda1}"

# Format root partition
mkfs.ext4 "/dev/${VG}/root"

# Create swap partition
mkswap "/dev/${VG}/swap"

# Format home partition
mkfs.ext4 "/dev/${VG}/home"

