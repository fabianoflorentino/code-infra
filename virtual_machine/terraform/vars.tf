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

variable "name_new_vm" {
  description = "Input a name for Virtual Machine Ex. new_vm"
}
variable "vm_count" {
  description = "Number of instaces"
}

variable "num_cpus" {
  description = "Amount of vCPU's"
}

variable "num_mem" {
  description = "Amount of Memory"
}