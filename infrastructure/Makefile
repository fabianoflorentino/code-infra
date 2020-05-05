.PHONY: help
.DEFAULT_GOAL := help

help:
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2, $$3, $$4, $$5}'

docker-build-terraform: ## Cria a imagem Docker para o uso do terraform
	@docker build -t servicesascode/infrastructure:terraform -f terraform.Dockerfile .

docker-run-terraform: ## Inicializa o container Docker com o terraform montando o diretorio corrente
	@docker run -it --name terraform -v ${PWD}:/infrastructure -w /infrastructure --entrypoint "" servicesascode/infrastructure:terraform sh