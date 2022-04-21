##
## Machine Image Builds
##

SHELL		?=	bash
BUILDER		?=	mkaczanowski/packer-builder-arm
INSTALLER	?=	bootstrap/base/install.sh
STACKS		?=	$(ls bootstrap/opt)

default: help

help: Makefile
	@sed -n 's/^##//p' $<

## armhf,arm64	build device image
%:
	docker run --rm --privileged \
		-v /dev:/dev \
		-v ${PWD}:/build \
		-w /build \
		${BUILDER} build \
			-var arch=${@} \
			-var name=${NAME} \
			-var installer=${INSTALLER} \
			/build/combox.pkr.hcl

base:
	NAME=$@ $(MAKE) arm

${STACKS}:
	INSTALLER=bootstrap/opt/$@ \
	NAME=$@ \
		$(MAKE) arm64

## 