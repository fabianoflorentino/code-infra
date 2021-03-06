#!/usr/bin/env bash

#
# Script to management docker image and container terraform, ansible
#

#
ARG_1=$1
ARG_2=$2

# Variaveis Communs
DOCKER_WORKDIR="/infrastructure"
DOCKER_IMAGE_NONE=$(docker images | grep "^<none>" |cut -d" " -f50)

# Informacoes sobre as opções do script
INFO_1="
--help          - Mostra estas opcoes

--build         - Cria uma nova imagem de container
--run           - Executa o container
--rm-container  - Remove o container
--rm-image      - Remove a imagem

--list          - Lista as imagens no Docker
--clean         - Remove imagens sem Nome/Tag <NONE>
"

INFO_2="
Selecione uma ferramenta:

* terraform
* ansible

"

function docker_verify() {

    # Verificar se o Docker esta instalado
    $(which docker) version > /dev/null
    if [ $? == 0 ];
    then
        DOCKER_VERSION=$(which docker version |grep "Version:" |head -n1 |awk '{ print $2 }')
    fi

}

# Informacoes para a ferramenta Terraform
function terraform_info() {
    
    # Variaveis para o Terraform
    IMAGE_NAME="infraascode/infrastructure:terraform"
    CONTAINER_NAME="terraform"
    DOCKER_FILE="terraform.Dockerfile"

}

# Informacoes para a ferramenta Ansible
function ansible_info() {
    
    # Variaveis para o Ansible
    IMAGE_NAME="infraascode/infrastructure:ansible"
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
        --rm-container)
            docker container rm -f ${CONTAINER_NAME}
            ;;
        --rm-image)
            docker image rm -f ${IMAGE_NAME}
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

docker_verify

if [ -z ${DOCKER_VERSION} ];
then

    if [ "${ARG_1}" == "terraform" ]; then
        
        terraform_info
        dck

    elif [ "${ARG_1}" == "ansible" ]; then

        ansible_info
        dck

    else

        echo -e "${INFO_2}"

    fi
else
    echo -e "\nDocker nao encontrado, por favor instale antes de continuar.\n"
fi