# Build New VM
data "vsphere_datacenter" "datacenter" {
    name = "${var.data_center}"
}

data "vsphere_datastore" "datastore" {
    name          = "${var.data_store}"
    datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_resource_pool" "pool" {}

data "vsphere_network" "networking" {
    name          = "${var.mgmt_lan}"
    datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

resource "vsphere_virtual_machine" "new_master" {
    count                      = "${var.vm_count_master}"
    name                       = "${var.name_new_master}-${count.index + 1}"
    resource_pool_id           = "${data.vsphere_resource_pool.pool.id}"
    datastore_id               = "${data.vsphere_datastore.datastore.id}"
    force_power_off            = true
    shutdown_wait_timeout      = 1
    num_cpus                   = "${var.num_cpus_master}"
    memory                     = "${var.num_mem_master}"
    wait_for_guest_net_timeout = 0
    guest_id                   = "${var.guest_id}"
    nested_hv_enabled          = true
    network_interface {
        network_id   = "${data.vsphere_network.networking.id}"
        adapter_type = "${var.net_adapter_type}"
    }
    cdrom {
        datastore_id = "${data.vsphere_datastore.datastore.id}"
        path         = "${var.custom_iso_path}"
    }
    disk {
        size             = 35
        label            = "first-disk.vmdk"
        eagerly_scrub    = false
        thin_provisioned = true
    }
}

resource "vsphere_virtual_machine" "new_worker" {
    count                      = "${var.vm_count_worker}"
    name                       = "${var.name_new_worker}-${count.index + 1}"
    resource_pool_id           = "${data.vsphere_resource_pool.pool.id}"
    datastore_id               = "${data.vsphere_datastore.datastore.id}"
    force_power_off            = true
    shutdown_wait_timeout      = 1
    num_cpus                   = "${var.num_cpus_worker}"
    memory                     = "${var.num_mem_worker}"
    wait_for_guest_net_timeout = 0
    guest_id                   = "${var.guest_id}"
    nested_hv_enabled          = true
    network_interface {
        network_id   = "${data.vsphere_network.networking.id}"
        adapter_type = "${var.net_adapter_type}"
    }
    cdrom {
        datastore_id = "${data.vsphere_datastore.datastore.id}"
        path         = "${var.custom_iso_path}"
    }
    disk {
        size             = 50
        label            = "first-disk.vmdk"
        eagerly_scrub    = false
        thin_provisioned = true
    }
}