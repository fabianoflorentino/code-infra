#!/usr/bin/env bash

#
# Script to management docker image and container terraform
#

#
ARG_1=$1
ARG_2=$2

# Variaveis Communs
DOCKER_WORKDIR="/infrastructure"
DOCKER_IMAGE_NONE=$(docker images | grep "^<none>" |cut -d" " -f50)

# Informacoes sobre as opções do script
INFO_1="
--help              - Mostra as opcoes

--build-terraform   - Cria uma nova imagem de container terraform
--run-terraform     - Executa o container do terraform
--delete-terraform  - Remove o container do terraform

--build-ansible     - Cria uma nova imagem de container ansible
--run-ansible       - Executa o container do ansible
--delete-ansible    - Remove o container do ansible

--list              - Lista as imagens no Docker
--clean             - Remove imagens sem Nome/Tag <NONE>
"

INFO_2="
Selecione uma ferramenta:

* terraform
* ansible

"

# Informacoes para a ferramenta Terraform
function terraform_info() {
    
    # Variaveis para o Terraform
    IMAGE_NAME="servicesascode/infrastructure:terraform"
    CONTAINER_NAME="terraform"
    DOCKER_FILE="terraform.Dockerfile"

}

# Informacoes para a ferramenta Ansible
function ansible_info() {
    
    # Variaveis para o Ansible
    IMAGE_NAME="servicesascode/infrastructure:ansible"
    CONTAINER_NAME="ansible"
    DOCKER_FILE="ansible.Dockerfile"

}

# Comandos para manipulacao do Docker
function dck() {

    # Comandos executados peloe scripts
    case ${ARG_2} in

        --build)
            docker build -t "${IMAGE_NAME}" -f  ${DOCKER_FILE} .
            ;;
        --run)
            docker run -it --name ${CONTAINER_NAME} \
            -v ${PWD}:${DOCKER_WORKDIR} -w ${DOCKER_WORKDIR} \
            --entrypoint "" "${IMAGE_NAME}" sh
            ;;
        --delete)
            docker container rm -f ${CONTAINER_NAME}
            ;;
        --list)
            docker image ls
            ;;
        --clean)
            docker rmi -f "${IMAGE_NONE}"
            ;;
        --help)
            echo -e "${INFO_1}"
            ;;
        *)
            echo -e "${INFO_1}"
            ;;

    esac

}

if [ "${ARG_1}" == "terraform" ]; then

    terraform_info
    dck

elif [ "${ARG_1}" == "ansible" ]; then

    ansible_info
    dck

else

    echo -e "${INFO_2}"

fi
