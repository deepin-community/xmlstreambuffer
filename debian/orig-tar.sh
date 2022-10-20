#!/bin/sh -e

VERSION=$2
TAR=../xmlstreambuffer_$VERSION.orig.tar.xz
DIR=xmlstreambuffer-$VERSION
TAG=$(echo "streambuffer-$VERSION" | sed -re's/~(alpha|beta)/-\1-/')

svn export https://svn.java.net/svn/xmlstreambuffer~svn/tags/${TAG}/ $DIR
XZ_OPT=--best tar -c -J -f $TAR \
    --exclude '*.jar' \
    --exclude '*.class' \
    --exclude '*.ipr' \
    --exclude '*.iml' \
    --exclude '.settings' \
    --exclude '.project' \
    --exclude '.classpath' \
    --exclude '*.zip' \
 $DIR
rm -rf $DIR ../$TAG

# move to directory 'tarballs'
if [ -r .svn/deb-layout ]; then
  . .svn/deb-layout
  mv $TAR $origDir && echo "moved $TAR to $origDir"
fi
