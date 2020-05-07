# Services as Code

## **Descrição**

Instalação e configuração de serviços de infraestrutura com Terraform e Ansible.

### **Serviços**

- [x] Márquina Virtual VMware/vSphere
- [x] Kubernetes Cluster
- [x] HAProxy
- [x] Jenkins
- [x] Elastic Stack

## **Infraestrutura**

- [x] **Ansible**
  - Gerencia de configuração do sistema e serviços bases para máquina virtual
- [x] **Terrafom**
  - Provisionamento da infraestrutura no Virtualizador VMWare/vSphere
  
- ### **Ansible**

- ### **Terraform**

  - **Sample**  
    Módulo para para criar máquina virtual no VMWare/vSphere
    - **Uso - Sample**  
    Crie um módulo para provisionar as máquinas virtuais no ambiente a partir do módulo **sample**

    ```shell
    cd ./infrastructure/terraform/modules

    cp -rf sample <SUA INFRAESTRUTURA>
    ```

    Ex.

    ```shell
    cp -rf sample kubernetes
    ```

No arquivo **modules.tf** preencha com as informações da sua infraestrutura.

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

Para cada novo módulo criado é preciso inicializar o terraform para que ele reconheça o novo módulo

```shell
terraform init
```
