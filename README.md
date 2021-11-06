# .gentoo

_Miscellaneous files to assist in maintaining Gentoo Linux._

## Instructions

### Clone releng repository

```sh
mkdir -p ~/src
git clone https://anongit.gentoo.org/git/proj/releng.git ~/src/gentoo-releng
```

### Setup .gentoo repository

```sh
git clone https://github.com/oxr463/gentoo-dotfiles.git ~/.gentoo
cd ~/.gentoo
docker-compose build
docker-compose run gentoo-sdk /bin/sh
```

## License

SPDX-License-Identifier: [0BSD](https://spdx.org/licenses/0BSD.html)

