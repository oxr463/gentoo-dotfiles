#!/bin/sh
set -e

DISTFILES_LATEST_URL="https://distfiles.gentoo.org/releases/amd64/autobuilds"

DEFAULT_CATALYST_TMP="/var/tmp/catalyst/builds/default"

create_catalyst_tmp() {
  mkdir -p "${DEFAULT_CATALYST_TMP}"
}

get_seed_tarball() {
  latest_stage3=$(curl -sqL "${DISTFILES_LATEST_URL}/latest-stage3-amd64.txt" | \
    awk '!/^#/ { print $1 }') # do not print comment lines

  curl -L "${DISTFILES_LATEST_URL}/${latest_stage3}" -o "${DEFAULT_CATALYST_TMP}/stage3-amd64-latest.tar.xz"
}

create_portage_snapshot() {
  catalyst -s "$(date +%Y.%m.%d)"
}

create_distfiles() {
  mkdir -p /var/cache/distfiles
}

main() {
  create_catalyst_tmp
  get_seed_tarball &
  create_portage_snapshot &
  create_distfiles

  wait
}

if [ "$(basename "${0}")" = "catalyst_setup.sh" ]; then
  main "${@}"
fi

