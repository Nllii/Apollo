scripts_path:=$(HOME)/workflow/scripts
include $(scripts_path)/common.mk
SERVICE := java
.ONESHELL:
.PHONY: is_script
is_script:
	ls -l $(scripts_path)
	bash $(scripts_path)/setup-server.sh -install-java

