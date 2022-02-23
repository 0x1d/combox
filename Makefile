##
## Machine Image Builds
##
SHELL=bash
DEPS_DIR				?= .deps
ARM_BUILDER_PATH		?= ${DEPS_DIR}/packer-builder-arm
PACKER_PLUGIN_PATH		?= ${ARM_BUILDER_PATH}
ARM_PACKER 				?= https://github.com/mkaczanowski/packer-builder-arm

default: help

help: Makefile
	@sed -n 's/^##//p' $<

compose-%:
	docker-compose -f $@.yaml up

.deps:
	-mkdir -p ${DEPS_DIR}

.deps/packer: .deps
	cd .deps && \
		wget https://releases.hashicorp.com/packer/1.7.10/packer_1.7.10_linux_amd64.zip && \
		unzip packer_1.7.10_linux_amd64.zip && \
		rm packer_1.7.10_linux_amd64.zip

.deps/packer-builder-arm: .deps/packer
	git clone ${ARM_PACKER} ${ARM_BUILDER_PATH}
	cd ${ARM_BUILDER_PATH} && go mod download && go build

## %		armhf
armhf: ${PACKER_PLUGIN_PATH}
	PACKER_PLUGIN_PATH=$< \
		${DEPS_DIR}/packer build $@.pkr.hcl

## cleanup		Delete device builder sources
cleanup:
	rm -rf ${DEPS_DIR}

dbuild:
	docker run --rm --privileged -v /dev:/dev -v ${PWD}:/build mkaczanowski/packer-builder-arm build armhf.pkr.hcl
##
##