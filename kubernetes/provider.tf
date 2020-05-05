# Configure the vSphere Provider
provider "vsphere" {
  vsphere_server       = "< HOSTNAME / IP >"
  user                 = "< USER >"
  password             = "< PASSWORD >"
  allow_unverified_ssl = true
}
