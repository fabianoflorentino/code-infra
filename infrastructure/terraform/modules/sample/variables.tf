variable "data_center" {

  default = "ha-datacenter"

}

variable "data_store" {

  default = "vmdata_01"

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

  default = "iso/centos7-custom-img-disk65gb-latest.iso"

}

variable "label_disk" {

  default = "first-disk.vmdk"

}
variable "name_new_vm" {
}

variable "vm_count" {
}

variable "num_cpus" {
}

variable "num_mem" {
}

variable "size_disk" {
}