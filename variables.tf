variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "private_key_oci" {}
variable "public_key_oci" {}

variable "VCN-CIDR" {
  default = "10.0.0.0/16"
}

variable "cluster_options_kubernetes_network_config_pods_cidr" {
  default = "10.1.0.0/16"
}

variable "cluster_options_kubernetes_network_config_services_cidr" {
  default = "10.2.0.0/16"
}

variable "node_pool_quantity_per_subnet" {
  default = 2
}

variable "kubernetes_version" {
  default = "v1.14.8"
}

variable "ADs" {
  default = ["unja:EU-FRANKFURT-1-AD-1", "unja:EU-FRANKFURT-1-AD-2", "unja:EU-FRANKFURT-1-AD-3"]
}

variable "Shapes" {
 default = ["VM.Standard.E2.1","VM.Standard.E2.1.Micro","VM.Standard2.1","VM.Standard.E2.1","VM.Standard.E2.2"]
}

variable "Images" {
 # Oracle-Linux-7.7-2019.11.12-0 in Frankfurt
 default = ["ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa3bu75jht762mfvwroa2gdck6boqwyktztyu5dfhftcycucyp63ma"]
}

variable "ClusterName" {
  default = "FoggyKitchenOKECluster"
}

