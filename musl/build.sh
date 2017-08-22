#!/bin/bash

# Exit on error
set -e

# Clone repo
REPO=https://github.com/wangyu-/udp2raw-tunnel.git
cd /build
GIT_SSL_NO_VERIFY=true git clone --recursive ${REPO}
cd udp2raw-tunnel
git checkout "${REV}"

# Patch to support musl
patch -p1 < ../patches/001-musl-headers.patch

# Variables
ARCHS=(x86 x64 mips arm arm64)
ARCHGCC=(i486 x86_64 mips arm aarch64)
FLAGS="-s -DHAVE_MUSL -static -O3 -std=c++11 \
       -Wall -Wextra -Wno-unused-variable \
       -Wno-unused-parameter \
       -Wno-missing-field-initializers"
SOURCES="main.cpp lib/md5.c lib/aes_acc/aes*.c \
         encrypt.cpp log.cpp network.cpp common.cpp"
ASMDIR="lib/aes_acc/asm"
NAME="udp2raw"
TAR="/bin.tgz"

# Compiling
echo "==> Compiling all archs..."
for i in "${!ARCHS[@]}"; do \
  ARCH="${ARCHS[$i]}"
  [[ "$ARCH" == "arm" ]] && HF="eabihf" || HF=""  # Use hard float for arm
  [[ "$ARCH" == "mips" ]] && BE="_be" || BE=""    # Big-endian for mips
  [[ "$ARCH" == "arm64" ]] && FLAGS="$FLAGS \
    -march=armv8-a+crypto -mcpu=cortex-a53"       # Enable armv8 intrinsics
  CC="${ARCHGCC[$i]}-linux-musl${HF}-g++"
  ASM="${ARCH}${BE}.S"
  echo "  ==> Compiling for ${ARCH}"
  ${CC} -o ${NAME}_${ARCH} ${SOURCES} ${ASMDIR}/${ASM} ${FLAGS}
done

# Packaging
BINS=("${ARCHS[@]/#/${NAME}_}")
PREFIX="${NAME}-${REV}"
tar --xform="s%^%${PREFIX}/%" -zcf ${TAR} \
  $(IFS=" "; echo "${BINS[*]}")
echo "==> Done"
