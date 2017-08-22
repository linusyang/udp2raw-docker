NAME=udp2raw
IMAGE=$(NAME)-docker
VER=e6f0ed0

all: linux-musl linux-openwrt-uclibc linux-openwrt-lede

linux-%:
	$(eval TGT := $(@:linux-%=%))
	docker build --force-rm -t $(IMAGE)-$(TGT) --build-arg REV=$(VER) -f $(subst -,/,$(TGT))/Dockerfile .
	docker run --rm --entrypoint cat $(IMAGE)-$(TGT) /bin.tgz > $(NAME)-$(TGT)-bin.tar.gz

clean:
	rm -f $(NAME)-*-bin.tar.gz
	$(eval DELIMG := $(shell docker images -q --filter reference='$(IMAGE)-*'))
	! [ -z "$(DELIMG)" ] && docker rmi $(DELIMG) || true

.PHONY: all clean linux-%
