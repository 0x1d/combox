##
## Machine Image Builds
##

SHELL	?=	bash
BUILDER	?=	mkaczanowski/packer-builder-arm

default: help

help: Makefile
	@sed -n 's/^##//p' $<

## build	Create device image
build:
	docker run --rm --privileged -v /dev:/dev -v ${PWD}:/build ${BUILDER} build /build/armhf.pkr.hcl

##