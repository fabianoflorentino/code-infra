# Infra as Code

## **Descrição**

Instalação e configuração de serviços de infraestrutura com Terraform e Ansible.

### **Infraestrutura de serviços**

- [x] Márquina Virtual VMware/vSphere
- [x] Kubernetes Cluster
- [x] HAProxy
- [x] Jenkins
- [x] Elastic Stack

## **Infraestrutura**

- [x] **Terrafom**
  - Provisionamento da infraestrutura no Virtualizador VMWare/vSphere
- [x] **Ansible**
  - Gerencia de configuração do sistema e serviços bases para máquina virtual

- ### **Terraform**

  - **Terraform Sample**  
    Módulo para para criar máquina virtual no VMWare/vSphere
    - **Uso - Terraform Sample**  
    Crie um módulo para provisionar as máquinas virtuais no ambiente a partir do módulo [**sample**](./infrastructure/terraform/modules)

    ```shell
    cd ./infrastructure/terraform/modules

    cp -rf sample <SUA INFRAESTRUTURA>
    ```

    Ex.

    ```shell
    cp -rf sample kubernetes
    ```

    No arquivo [**modules.tf**](./infrastructure/terraform/modules.tf) preencha com as informações da sua infraestrutura.

    **OBS:** Para cada novo módulo criado é preciso inicializar o terraform para que ele reconheça o novo módulo

    Ex.

    ```terraform
    module "kubernetes" {
      source = "./modules/kubernetes"

      vm_count      = "3"
      name_new_vm   = "kubernetes-node"
      num_cpus      = "2"
      num_mem       = "2048"
      size_disk     = "70"

    }
    ```

    ```shell
    terraform init
    terraform plan -out kubernetes.tfplan
    terraform apply kunernetes.tfplan
    ```

- ### **Ansible**

  - **Ansible Sample**  
    Inventário para gerenciamento das configurações dos servidores.
    - **Uso - Ansible Sample**
    Dentro do diretório [**inventorie**](./infrastructure/ansible/inventorie) crie uma cópia do inventário [**sample**](./infrastructure/ansible/inventorie/sample)

    ```shell
    cd ./infrastructure/ansible/inventorie

    cp -rf sample <SEU INVENTARIO>
    ```

    No arquivo **inventory.ini** preencha com os servidores que irão ser gerenciados.

    ```shell
    cd ./infrastructure/ansible/inventorie/<SEU INVENTARIO>

    vim inventory.ini
    ```

    Ex.

    ```ini
    [servers]
    # node1 ansible_host=1.2.3.4  ip=1.2.3.4
    kubernetes-master ansible_host=1.2.3.4 ip=1.2.3.4
    ```

    no arquivo **servers.yml** dentro do seu inventário **./infrastructure/ansible/inventorie/<SEU INVENTARIO>/group_vars/servers.yml** configure a chave ssh que o ansible irá usar para executar os playbooks

    ```yaml
    ssh_key:
    # SSH Information: ~${USER}/.ssh/id_rsa.pub
    - ""
    ```

    Ex.

    ```yaml
    ssh_key:
    # SSH Information: ~${USER}/.ssh/id_rsa.pub
    - "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDhzzHA/GhSSNfDeN68TmnKi7BpbbVQVpFzUvVpx7bANff612htvM1jJCbwud1TKUO+iH34fJGg1LRJEQlpopjvoW21T2qPSwZoocoqupcCzwPm5/J0BqPRZJdYewQUTDtmz77bRD6sKCGgT7z+31NvnzZZjQOTJvfUMQnMDd78rtcp8ktTVf+3F9f3mBVHNcu8Qn6a1RuT+Wnl7WWYTX7q3Irk0p/ZRWkYX6t+jrrSf+4nKocCeLC6tEKssJCV6VaL8YAkzLalOKWJj7dfXIxWhc9An16cVHANFl/xUlQYH3nNyg7MIFcKPFAUrJ+6mU4KiqS9yVDJdZF2ngdOeyob fabianoflorentino"
    ```

    Para usar o ansible contra seu inventário execute.

    ```shell
    cd ./infrastructure/ansible

    ansible-playbook -i inventorie/<SEU INVENTARIO>/inventory.ini -u root -k playbook.yml
    ```

    - Temos 2 roles basicas para a infraestrutura que esta sendo montada.
      - [x] ssh
        - Configura a chave SSH do usário que está rodando o ansible
      - [x] common
        - Configura o basico para os servidores.
          - [x] Atualização do Sistema Operacional
          - [x] Instalando Pacotes Padrão
          - [x] Habilitando Serviços Padrão
          - [x] Desabilitando serviços não essenciais
          - [x] Desabilitando o SELinux
          - [x] Configurando o Serviço NTP
          - [x] Atualizando o Hostname dos Servidores
