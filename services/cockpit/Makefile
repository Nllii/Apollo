scripts_path:=$(HOME)/workflow/scripts
include $(scripts_path)/common.mk
SERVICE := cockpit
.ONESHELL:
.PHONY: is_docker-compose
is_script:
	ls -l $(scripts_path)
	bash $(scripts_path)/setup-server.sh -cockpit

