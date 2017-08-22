NAME=udp2raw
VER=master
MUSLBIN=${NAME}-bin.tar.gz
AR71BIN=${NAME}-ar71xx-bin.tar.gz
IMAGE=$(NAME)
IMAGEAR=$(NAME)-ar71xx

all: musl ar71xx

musl:
	docker build --force-rm -t $(IMAGE) --build-arg REV=$(VER) -f linux-musl/Dockerfile .
	docker run --rm --entrypoint cat $(IMAGE) /bin.tgz > $(MUSLBIN)

ar71xx:
	docker build --force-rm -t $(IMAGEAR) -f openwrt-ar71xx/Dockerfile .
	docker run --rm --entrypoint cat $(IMAGEAR) /bin.tgz > $(AR71BIN)

clean:
	rm -f $(MUSLBIN) $(AR71BIN)
	docker rmi $(IMAGE) $(IMAGEAR)

.PHONY: all musl ar71xx clean
