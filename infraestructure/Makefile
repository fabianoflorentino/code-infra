.PHONY: help
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'

deploy-vm: ## Create a new virtual machine onpremise infraestructure
	@terraform init
	@terraform plan --out=deploy-vm.tfplan
	@terraform apply deploy-vm.tfplan

destroy-vm: ## Destroy the onpremise infraestructure
	@terraform init
	@terraform destroy --auto-approve --force

test-conn: ## Does test connection with virtual machines
	@ansible -i inventory/hosts.ini all -u root -k -m ping

install-ssh: ## Create and installe a user for ssh connection
	@ansible-playbook -i inventory/hosts.ini ssh.yml -u root -k -e ansible_ssh_user=root

build-vm: ## Build a new virtual machine onpremise infraestucture
	@ansible-playbook -i inventory/hosts.ini build.yml -u ansible -b -e ansible_ssh_user=ansible