#
# Variables with default values, alter according to the your environment.
#
variable "data_center" {
  default = "ha-datacenter"
}

variable "data_store" {
  default = "vmdt-1"
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
  default = "iso_images/custom-centos7-v7.iso"
}

variable "name_new_master" {
  description = "Input a name for new k8s master Ex. k8s-master"
}

variable "name_new_worker" {
  description = "Input a name for new k8s worker Ex. k8s-worker"
}
variable "vm_count_master" {
  description = "Number of instaces master"
}
variable "vm_count_worker" {
  description = "Number of instaces worker"
}

variable "num_cpus_master" {
  description = "Amount of vCPU's"
}

variable "num_cpus_worker" {
  description = "Amount of vCPU's"
}

variable "num_mem_master" {
  description = "Amount of Memory"
}

variable "num_mem_worker" {
  description = "Amount of Memory"
}