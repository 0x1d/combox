##
## Machine Image Builds
##

SHELL	?=	bash
BUILDER	?=	mkaczanowski/packer-builder-arm
INSTALLER?=bootstrap/nomad.sh

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

raspap:
	INSTALLER=bootstrap/base/raspap.sh \
	NAME=raspap \
		$(MAKE) armhf
nomad:
	INSTALLER=bootstrap/base/nomad.sh \
	NAME=nomad \
		$(MAKE) armhf
docker:
	INSTALLER=bootstrap/base/docker.sh \
	NAME=docker \
		$(MAKE) arm64

##