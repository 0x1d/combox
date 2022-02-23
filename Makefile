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
	cd compose && docker-compose -f $@.yaml up

## .deps		Build dependencies from source
.deps:
	-mkdir -p ${DEPS_DIR}
	-git clone ${ARM_PACKER} ${ARM_BUILDER_PATH}
	cd ${ARM_BUILDER_PATH} && go mod download && go build

## combox-%		ComBox images		
combox-%: .deps
	sudo PACKER_PLUGIN_PATH=${ARM_BUILDER_PATH} \
		packer build $@.pkr.hcl

## cleanup		Delete device builder sources
cleanup:
	rm -rf ${DEPS_DIR} ; \
	rm -rf packer_cache

##
##