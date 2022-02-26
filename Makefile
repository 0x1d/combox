##
## Machine Image Builds
##

SHELL	?=	bash
BUILDER	?=	mkaczanowski/packer-builder-arm

default: help

help: Makefile
	@sed -n 's/^##//p' $<

## build	Create device image
%:
	docker run --rm --privileged -v /dev:/dev -v ${PWD}:/build ${BUILDER} build -var arch=${@} /build/combox.pkr.hcl

##