#!/bin/sh

set -e

if [ -z "$IS_ARM" ]; then
  TYPES_OF_BUILD="x86_64"
else
  TYPES_OF_BUILD="aarch64"
fi
THREADS=16

WORKDIR="$(pwd)/"build
CACHEDIR="$(pwd)/"cache
mkdir -p $CACHEDIR

OPENSSL_FILENAME=openssl-1.1.1k.tar.gz
OPENSSL_FILE_PATH=$CACHEDIR/$OPENSSL_FILENAME
OPENSSL_SRC_DIR=$WORKDIR/openssl-1.1.1k
OPENSSL_SHA256="892a0875b9872acd04a9fde79b1f943075d5ea162415de3047c327df33fbaee5"

ZLIB_DIR=$WORKDIR/zlib
ZLIB_TAG=v1.2.11
ZLIB_COMMIT_HASH="cacf7f1d4e3d44d871b605da3b647f07d718623f"

# If a zlib dir exists, we assume that it's already been built.
# TODO make a better zlib-validity check.
if [ ! -d "$ZLIB_DIR" ] ; then
  git clone -b $ZLIB_TAG --depth 1 https://github.com/madler/zlib $ZLIB_DIR
  cd $ZLIB_DIR
  git reset --hard $ZLIB_COMMIT_HASH
  ./configure --static
  make
fi

# Download openssl if it doesn't exist.
curl https://www.openssl.org/source/$OPENSSL_FILENAME -o $OPENSSL_FILE_PATH

# Validate checksum.
echo $OPENSSL_SHA256 $OPENSSL_FILE_PATH | sha256sum -c - || exit 1

# Build openssl for each arch.
for arch in $TYPES_OF_BUILD
do
	echo "Building $TYPES_OF_BUILD"
	PREFIX=$WORKDIR/prefix_${arch}

	case $arch in
		"x86_64")  X_ARCH="linux-x86_64";;
		"aarch64")  X_ARCH="linux-aarch64";;
		*)	   X_ARCH="linux-x86_64";;
	esac

	cd $WORKDIR
	# Don't delete the openssl source dir.  We don't need clean builds every time.
  #	rm -rf $OPENSSL_SRC_DIR
	tar -xzf $OPENSSL_FILE_PATH -C $WORKDIR
	cd $OPENSSL_SRC_DIR

	#sed -i -e "s/mandroid/target\ ${TARGET}\-linux\-android/" Configure
		./Configure ${X_ARCH} \
		no-asm no-shared \
		--with-zlib-include=${PREFIX}/include \
		--with-zlib-lib=${PREFIX}/lib \
		--prefix=${PREFIX} \
		--openssldir=${PREFIX}
	make -j$THREADS
	make -j$THREADS install_sw
done
