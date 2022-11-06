scripts_path:=$(HOME)/workflow/scripts
docker_project_path:=$(HOME)/workflow/services/docpht_docker/docpht
include $(scripts_path)/common.mk
SERVICE := docpht_workflow
wait = \e[1;35mwait for a while to let the server start up \nor fix any errors if there is any $<\e[0m
VERSION := latest
guess_ip := $(shell hostname -I )
	
.ONESHELL:
# .PHONY: is_script
.PHONY: is_script
is_script: ## Start all containers in background
	@echo "building $(SERVICE)"
	bash $(scripts_path)/setup-server.sh -install-docpht
	cd $(docker_project_path)
	@echo "listing directories in $(docker_project_path) ... make sure Dockerfile is in there"
# ls -l $(_scripts_path)
	sudo docker build -t $(SERVICE) .
	bash $(scripts_path)/setup-server.sh -install-persistence_data
	@echo -e  "$(wait)"
	@echo "$(SERVICE) is probably running on these ips on port 8070"
	@echo
	@echo "http://$(guess_ip):8070"







# is_script:
# 	ls -l $(scripts_path)

