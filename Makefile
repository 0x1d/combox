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

sys-debian:
	curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
	sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
	sudo apt-get update && sudo apt-get install golang qemu-system-arm packer

## .deps		Build dependencies from source
.deps: sys-debian
	-mkdir -p ${DEPS_DIR}
	-git clone ${ARM_PACKER} ${ARM_BUILDER_PATH}
	cd ${ARM_BUILDER_PATH} && go mod download && go build


## %		armhf	
%: .deps
	sudo PACKER_PLUGIN_PATH=${ARM_BUILDER_PATH} \
		packer build $@.pkr.hcl

## cleanup		Delete device builder sources
cleanup:
	rm -rf ${DEPS_DIR} ; \
	rm -rf packer_cache

##
##