##
## Machine Image Builds
##

DEPS_DIR				?= .deps
ARM_BUILDER_PATH		?= ${DEPS_DIR}/packer-builder-arm
ARM_PACKER 				?= https://github.com/mkaczanowski/packer-builder-arm

default: help

help: Makefile
	@sed -n 's/^##//p' $<

compose-%:
	docker-compose -f $@.yaml up

.PHONY: buildsys
buildsys: .deps
	#sudo apt-get update && sudo apt-get install golang qemu-system-arm wget unzip
	cd .deps && \
		wget https://releases.hashicorp.com/packer/1.7.10/packer_1.7.10_linux_amd64.zip && \
		unzip packer_1.7.10_linux_amd64.zip && \
		rm packer_1.7.10_linux_amd64.zip

## .deps		Build dependencies from source
.deps:
	-mkdir -p ${DEPS_DIR}
	-git clone ${ARM_PACKER} ${ARM_BUILDER_PATH}
	cd ${ARM_BUILDER_PATH} && go mod download && go build


## %		armhf	
%: buildsys
	sudo PACKER_PLUGIN_PATH=${ARM_BUILDER_PATH} \
		./deps/packer build $@.pkr.hcl

## cleanup		Delete device builder sources
cleanup:
	rm -rf ${DEPS_DIR} ; \
	rm -rf packer_cache

##
##