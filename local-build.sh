#!/bin/bash
sudo chown -R "$(whoami)" "${PWD}/"
uscan --verbose --force-download --download-current-version
sudo mk-build-deps --remove  --install --tool="apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends --yes" debian/contro
sudo rm -rf ./*deps*.deb
dpkg-buildpackage --build=source
dpkg-buildpackage
