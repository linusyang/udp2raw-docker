NAME=udp2raw
VER=master

all: musl openwrt-uclibc openwrt-lede

musl:
	docker build --force-rm -t $(NAME)-$@ --build-arg REV=$(VER) -f $@/Dockerfile .
	docker run --rm --entrypoint cat $(NAME)-$@ /bin.tgz > $(NAME)-$@-bin.tar.gz

openwrt-%:
	docker build --force-rm -t $(NAME)-$@ -f $(subst -,/,$@)/Dockerfile .
	docker run --rm --entrypoint cat $(NAME)-$@ /bin.tgz > $(NAME)-$@-bin.tar.gz

clean:
	rm -f $(NAME)-*-bin.tar.gz
	docker rmi $(NAME)-*

.PHONY: all musl openwrt-% clean
