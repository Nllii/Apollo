scripts_path:=$(HOME)/workflow/scripts
include $(scripts_path)/common.mk
SERVICE := docker
.ONESHELL:
.PHONY: is_script
is_script:
	ls -l $(scripts_path)
	bash $(scripts_path)/setup-server.sh -install-docker

