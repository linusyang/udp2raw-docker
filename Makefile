NAME=udp2raw
IMAGE=$(NAME)-docker
VER=master

all: musl openwrt-uclibc openwrt-lede

musl:
	docker build --force-rm -t $(IMAGE)-$@ --build-arg REV=$(VER) -f $@/Dockerfile .
	docker run --rm --entrypoint cat $(IMAGE)-$@ /bin.tgz > $(NAME)-$@-bin.tar.gz

openwrt-%:
	docker build --force-rm -t $(IMAGE)-$@ -f $(subst -,/,$@)/Dockerfile .
	docker run --rm --entrypoint cat $(IMAGE)-$@ /bin.tgz > $(NAME)-$@-bin.tar.gz

clean:
	rm -f $(NAME)-*-bin.tar.gz
	$(eval DELIMG := $(shell docker images -q --filter reference='$(IMAGE)-*'))
	! [ -z "$(DELIMG)" ] && docker rmi $(DELIMG) || true

.PHONY: all musl openwrt-% clean
