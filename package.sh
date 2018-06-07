#!/bin/bash
set -e

NAME="furhat-create-ap"
VERSION="1.0.0"
ARCH="amd64"

PACKAGE=$NAME\_$VERSION\_$ARCH

mkdir -p $PACKAGE
mkdir -p $PACKAGE/DEBIAN
mkdir -p $PACKAGE/usr/share/bash-completion/completions/
mkdir -p $PACKAGE/usr/bin/
mkdir -p $PACKAGE/usr/lib/systemd/system/
mkdir -p $PACKAGE/etc/
mkdir -p $PACKAGE/usr/share/doc/create_ap/

cp bash_completion $PACKAGE/usr/share/bash-completion/completions/create_ap
cp create_ap $PACKAGE/usr/bin/
cp create_ap.conf $PACKAGE/etc/
cp create_ap.service $PACKAGE/usr/lib/systemd/system/
cp README.md  $PACKAGE/usr/share/doc/create_ap/

cat > $PACKAGE/DEBIAN/control << EOL
Section: main
Package: furhat-create-ap
Version: 1.0.0
Depends: util-linux, procps, hostapd, iproute2, iw
Maintainer: Filip de Figueiredo <fil@furhatrobotics.com>
Architecture: amd64
Description: Forked package of create_ap, a service for hosting networks. Create_ap allows the machine to host a network while being connected to one.
EOL

#chmod a+x $PACKAGE/DEBIAN/postinst

dpkg-deb -Zgzip --build $PACKAGE
