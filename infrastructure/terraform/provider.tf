provider "vsphere" {
  
  version               = "1.15.0"
  vsphere_server        = var.provider_address
  user                  = var.provider_user
  password              = var.provider_password
  allow_unverified_ssl  = true

}