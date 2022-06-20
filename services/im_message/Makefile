scripts_path:=$(HOME)/workflow/scripts
include $(scripts_path)/common.mk
docker_project_path:=$(HOME)/workflow/services/im_message/snikket

SERVICE := snikket
.ONESHELL:
.PHONY: is_script
is_script:
	@echo "building $(SERVICE)"
	cd $(docker_project_path)
	ls -l $(docker_project_path)
	sudo docker-compose build --no-cache 
	sudo docker-compose up -d 
	docker exec snikket create-invite --admin --group default

