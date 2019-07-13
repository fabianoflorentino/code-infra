# **Terraform and Ansible to build VMware onpremise Infraestructure**

## **Modules**

* ## **build-vm**  

Provisions a new virtual machine on vmware vsphere on premise infraestructure.

**Makefile:**  
The makefile helps automate to build and deploy the new infraestructure.

![make help](/docs/img/img1.png)

Edit for your environment.

**provider.tf:**  
Set information to access VMWware vSphere/vCenter API's to management the new infraestructure.

```terraform
provider "vsphere" {
vsphere_server       = "< HOSTNAME / IP >"
user                 = "< USER >"
password             = "< PASSWORD >"
allow_unverified_ssl = true
}
```

**vars.tf:**  
Set information of your onpremise vmware infraestrucutre.

```terraform
variable "data_center" {
default = "ha-datacenter"
}

variable "data_store" {
default = "vmdt-01"
}

variable "mgmt_lan" {
default = "VM Network"
}

variable "net_adapter_type" {
default = "vmxnet3"
}


variable "guest_id" {
default = "centos7_64Guest"
}

variable "custom_iso_path" {
default = "iso_images/CentOS-7-x86_64-Minimal-1810.iso"
}
```

**all.yml:**  
YAML file to set information to all nodes.

```yaml
ssh_key: 
# SSH Information: ~${USER}/.ssh/id_rsa.pub
- ""
```

**host.ini:**  
Configure the hosts to management with ansible.

```ìni
[all]
# node1 ansible_host=1.2.3.4  ip=1.2.3.4
```

- ## **build-haproxy**  

Provisions a new servers haproxy mode http on vmware vsphere on premise infraestructure.

**Requirements:**  

* deploy a new's virtual machines with **```build-vm```** module first.

**Makefile:**  
The makefile helps automate to build and deploy the new infraestructure.

![make help](/docs/img/img2.png)

Edit for your environment.

**all.yml:**  
YAML file to set information to all nodes on kubernetes cluster.

```yaml
ssh_key:
# SSH Information: ~${USER}/.ssh/id_rsa.pub
- ""
```

**haproxy.yml:**  
YAML file to set information to all nodes on haproxy high avalibility.

```yaml
---
# Virtual IP for high avalibility with keepalived.
virtual_ipaddress: ""

# Hostname for first haproxy service, use the same hostname in inventory_hostname.
# Ex:
# haproxy_master: "haproxy-1"
haproxy_master: ""

# Select one algorithm for load balance: first, leastconn, static-rr or roundrobin.
balance_algorithm: ""

# Select one mode for HAProxy: http or tcp
haproxy_mode: ""

# Domain used in infraestructure
my_domain: ""

# If you need configure new app repeat block above new_app variable.
# Ex:
# new_app:
#   app_1:
#     name: "api_1"
#     port_front: 8070
#     port_back: 30870
#     backend: {
#       "hostname_1": "10.0.0.1",
#       "hostname_2": "172.16.0.1",
#       "hostname_3": "192.168.0.1"
#     }
#   app_2:
#     name: "api_2"
#     port_front: 8071
#     port_back: 30871
#     backend: {
#       "hostname_1": "10.0.0.1", # Finish previous line with "," for more than one backend.
#       "hostname_2": "172.16.0.1",
#       "hostname_3": "192.168.0.1"
#     }
new_app:
  <APP NAME>:
    name: "<APP NAME>"
    port_front: <APP PORT FRONTEND>
    port_back: <APP PORT BACKEND>
    backend: {
      "<HOSTNAME BACKEND>": "<IP BACKEND>"
    }

```

**hosts.ini:**  
Configure the hosts to deploy a new HAProxy HA mode http.

```ini
[all]
# haproxy-1 ansible_host=172.16.245.10  ip=172.16.245.10
# haproxy-2 ansible_host=172.16.245.11  ip=172.16.245.11

[haproxy]
# haproxy-1
# haproxy-2
```

* ## **build-kubernetes-cluster**

Provisions a new servers kubernetes on vmware vsphere on premise infraestructure.

**OBS:** The propose this module is provisions a new cluster with single node master to development and study, do not consider use in production environment. To production environment use homologed solutions. <https://kubernetes.io/docs/setup/production-environment/tools/kubespray/>

**Makefile:**  
The makefile helps automate to build and deploy the new infraestructure.

![make help](/docs/img/img3.png)

Edit for your environment.

**provider.tf:**  
Set information to access VMWware vSphere/vCenter API's to management the new infraestructure.

```terraform
provider "vsphere" {
vsphere_server       = "< HOSTNAME / IP >"
user                 = "< USER >"
password             = "< PASSWORD >"
allow_unverified_ssl = true
}
```

**vars.tf**  
Set information of your onpremise vmware infraestrucutre.

```terraform
#
# Variables with default values, alter according to the your environment.
#
variable "data_center" {
default = "ha-datacenter"
}

variable "data_store" {
default = "vmdt-01"
}

variable "mgmt_lan" {
default = "VM Network"
}

variable "net_adapter_type" {
default = "vmxnet3"
}

variable "guest_id" {
default = "centos7_64Guest"
}

variable "custom_iso_path" {
default = "iso_images/CentOS-7-x86_64-Minimal-1810.iso"
}

```

**all.yml:**  
YAML file to set information to all nodes on kubernetes cluster.

```yaml
---
# Configure the IP for master node.
k8s_master_node_ip: ""
k8s_api_secure_port: 6443

ssh_key:
# SSH Information: ~${USER}/.ssh/id_rsa.pub
- ""
```

**master.yml:**  
YAML file to set information about node master on kubernetes cluster.

```yaml
---
# Confifure the network for POD's network. Ex: 192.168.0.0/16
pod_network_cidr: ""

# Weavenet Network Plugin
# If you look user weavenet plugin network let true option.
weavenet_network: true
default_kubernetes_cni_weavenet_manifestUrl: "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
```

**host.ini:**  
Configure the hosts to deploy a new cluster kubernetes.

```ini
[all]
# node1 ansible_host=1.2.3.4  ip=1.6.3.4
k8s-mst-1 ansible_host=192.168.0.1 ip=192.168.0.1
k8s-wrk-1 ansible_host=192.168.0.2 ip=192.168.0.2
k8s-wrk-2 ansible_host=192.168.0.3 ip=192.168.0.3


[master]
k8s-mst-1

[worker]
k8s-wrk-1
k8s-wrk-2
```

### **```(writing)```**
* ## **build-jenkins** 

Provisions a new servers jenkins on vmware vsphere on premise infraestructure.

**Requirements:**  

* deploy a new's virtual machines with **```build-vm```** module first.

**Makefile:**  
The makefile helps automate to build and deploy the new infraestructure.

![make help](/docs/img/img4.png)

Edit for your environment.

**all.yml:**  
YAML file to set information to all nodes on kubernetes cluster.

```yaml
---

ssh_key:
# SSH Information: ~${USER}/.ssh/id_rsa.pub
- ""
```

**hosts.ini:**  
Configure the hosts to deploy a new HAProxy HA mode http.

```ini
[all]
; jenkins-1 ansible_host=172.16.245.10  ip=172.16.245.10
; jenkins-2 ansible_host=172.16.245.11  ip=172.16.245.11

[master]
; jenkins-1

[slave]
; jenkins-2
```
