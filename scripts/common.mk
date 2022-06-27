DOCKER := docker
DOCKER_COMPOSE := docker-compose
DOCKER_COMPOSE_FILE := $(ROOT_DIR)/docker-compose.yml
SHELL := $(shell which bash)


.PHONY: is_enable
is_enable: ## Enable service
	@touch .enable


.PHONY: error
is_error: ## Disable service
# @rm -rf .enable
	@rm -rf .disabled
# @touch .disabled




# .PHONY: health
# health: ## Get service health
# 	@if [ "$$($(DOCKER) container inspect -f '{{.State.Status}}' $(SERVICE) 2>&1)" = "running" ]; then echo "UP"; else echo "DOWN"; fi



# build up down start stop restart destroy logs status:
# 	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) $(CMD)