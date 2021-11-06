#!/bin/sh
set -e

DISTFILES_URL="https://distfiles.gentoo.org"
AUTOBUILDS_URL="${DISTFILES_URL}/releases/amd64/autobuilds"

CATALYST_TMP="/var/tmp/catalyst"
CATALYST_BUILDS="${CATALYST_TMP}/builds/default"
CATALYST_SNAPSHOTS="${CATALYST_TMP}/snapshots"

DISTDIR="/var/cache/distfiles"

create_catalyst_dirs() {
  mkdir -p "${CATALYST_BUILDS}"
  mkdir -p "${CATALYST_SNAPSHOTS}"
}

get_seed_tarball() {
  latest_stage3=$(curl -sqL "${AUTOBUILDS_URL}/latest-stage3-amd64.txt" | \
    awk '!/^#/ { print $1 }') # do not print comment lines

  curl -L "${AUTOBUILDS_URL}/${latest_stage3}" \
    -o "${CATALYST_BUILDS_DEFAULT}/stage3-amd64-latest.tar.xz"
}

create_portage_snapshot() {
  catalyst -s "$(date +%Y.%m.%d)"
}

get_portage_snapshot() {
  curl -L "${DISTFILES_URL}/snapshots/portage-latest.tar.xz" \
    -o "${CATALYST_SNAPSHOTS}/gentoo-latest.tar.xz"
}

create_distfiles() {
  mkdir -p "${DISTDIR}"
}

main() {
  create_catalyst_dirs
  get_seed_tarball &
  get_portage_snapshot &
  create_distfiles

  wait
}

if [ "$(basename "${0}")" = "catalyst_setup.sh" ]; then
  main "${@}"
fi

