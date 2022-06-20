DOCKER := docker
DOCKER_COMPOSE := docker-compose
DOCKER_COMPOSE_FILE := $(ROOT_DIR)/docker-compose.yml
SHELL := $(shell which bash)


.PHONY: enable
enable: ## Enable service
	@rm -rf .disabled

.PHONY: disable
disable: down ## Disable service
	@touch .disabled



.PHONY: health
health: ## Get service health
	@if [ "$$($(DOCKER) container inspect -f '{{.State.Status}}' $(SERVICE) 2>&1)" = "running" ]; then echo "UP"; else echo "DOWN"; fi



build up down start stop restart destroy logs status:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) $(CMD)