#!/bin/bash
set -x
sudo chown -R "$(whoami)" "${PWD}/"
version=$(awk 'NR==1{gsub(/[()]/,"",$2); print $2 }' debian/changelog)
source /etc/lsb-release
dch --distribution "${DISTRIB_CODENAME}" --newversion "${version}+ubuntu${DISTRIB_RELEASE}" "Github build of ${DISTRIB_CODENAME} packages"
sudo uscan --verbose --force-download --download-current-version
sudo mk-build-deps --remove --install --tool="apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends --yes" debian/control
sudo rm -rf ./*deps*.{deb,buildinfo,changes}
dpkg-buildpackage -b -us -uc
mkdir -p ${RESULT_DIR}
mv ../*deb ${RESULT_DIR}
