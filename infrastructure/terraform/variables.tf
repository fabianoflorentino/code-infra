variable "provider_address" {
  default = "192.168.7.3"
}

variable "data_center" {
  default = "ha-datacenter"
}

variable "data_store" {
  default = "vol1"
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
  default = "iso/centos7-custom-img-disk50gb-v0.0.1.iso"
}

variable "label_disk" {
  default =  "first-disk.vmdk"
}

variable "provider_user" {
  default = "$TF_VAR_provider_user"
}

variable "provider_password" {
  default = "$TF_VAR_provider_password"
}

variable "name_new_vm" {
    description = "Input a name for Virtual Machine Ex. new_vm"
    default     = "$TF_VAR_name_new_vm"
}
variable "vm_count" {
    description = "Number of instaces"
    default     = "$TF_VAR_vm_count"
}

variable "num_cpus" {
    description = "Amount of vCPU's"
    default     = "$TF_VAR_num_cpus"
}

variable "num_mem" {
    description = "Amount of Memory"
    default     = "$TF_VAR_num_mem"
}

variable "size_disk" {
  default = "$TF_VAR_size_disk"
}