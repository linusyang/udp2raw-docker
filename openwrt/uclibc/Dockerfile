FROM yhnw/openwrt-sdk:15.05.1-ar71xx
COPY \
  openwrt/common/Makefile.openwrt \
  openwrt/common/udp2raw.init \
  openwrt/common/udp2raw.conf /
RUN \
  cd /home/openwrt/sdk && \
  mkdir -p package/udp2raw && \
  cp /Makefile.openwrt package/udp2raw/Makefile && \
  cp /udp2raw.conf package/udp2raw/ && \
  cp /udp2raw.init package/udp2raw/ && \
  su openwrt -c "make package/udp2raw/compile" && \
  cp bin/ar71xx/packages/base/udp2raw*.ipk /udp2raw-uclibc-ar71xx.ipk && \
  cp build_dir/target-*/udp2raw/udp2raw-*/ipkg-ar71xx/udp2raw/usr/bin/udp2raw /udp2raw-uclibc-ar71xx && \
  tar -zcvf /bin.tgz /udp2raw-uclibc-ar71xx.ipk /udp2raw-uclibc-ar71xx
