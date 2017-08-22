udp2raw-docker
======

Cross-compile [udp2raw-tunnel](https://github.com/wangyu-/udp2raw-tunnel) using Docker.

Usage
-----

Run `make` to compile `udp2raw` for all supported architectures. Compiled binaries will be archived in tarballs in the same folder.

Supported Targets
-----

1. Static Linux binaries linked with Musl Libc:

    * Intel (x86/x64)
    * ARM (32-bit/64-bit)
    * MIPS (big-endian only)

   Note that hardware-accelerated AES crypto is supported on 64-bit Intel and ARM.

2. Openwrt `.ipk` package and binary for ar71xx:

    * Target both old uClibc and new Musl/LEDE libraries
    * Use `opkg install` to install the `.ipk` file and service `udp2raw` will be installed
    * Edit `/etc/udp2raw.conf` to change command-line arguments

License
-----
GPLv3
