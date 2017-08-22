FROM yhnw/openwrt-sdk:lede-ar71xx
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
  su openwrt -c "make defconfig && make package/udp2raw/compile" && \
  cp bin/packages/mips_24kc/base/udp2raw*.ipk /udp2raw-lede-ar71xx.ipk && \
  cp build_dir/target-*/udp2raw/udp2raw-*/udp2raw /udp2raw-lede-ar71xx && \
  tar -zcvf /bin.tgz /udp2raw-lede-ar71xx.ipk /udp2raw-lede-ar71xx
