project_name = gilded-rose
image_name = ch2ch3/$(project_name)

## Tasks ######################################################################

default: build test

##
# Build the project image
build:
	@docker build --tag $(image_name) .
.PHONY: build

##
# Run the tests
test:
	@$(call task)
.PHONY: test

##
# Open a shell session
sh:
	@$(call task, /bin/sh)
.PHONY: sh

## Helpers ####################################################################

ifeq ("$(MOUNT_VOLUMES)", "true")
  volumes := --volume $(PWD):/home/ubuntu/gilded-rose
endif

define task
	docker run --rm -it \
             $(volumes) \
             $(image_name) \
             $1
endef
