.PHONY: help
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'

test-conn: ## Does test connection with virtual machines
	@ansible -i inventory/inventory.ini all -u root -k -m ping

config-jenkins: ## Build a new's servers Jenkins.
	@ansible-playbook -i inventory/inventory.ini jenkins.yml -u ansible -b -e ansible_ssh_user=ansible