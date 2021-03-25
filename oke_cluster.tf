
resource "oci_containerengine_cluster" "FoggyKitchenOKECluster" {
  #depends_on = [oci_identity_policy.FoggyKitchenOKEPolicy1]
  compartment_id     = oci_identity_compartment.FoggyKitchenCompartment.id
  kubernetes_version = var.kubernetes_version
  name               = var.ClusterName
  vcn_id             = oci_core_vcn.FoggyKitchenVCN.id

  options {
    service_lb_subnet_ids = [oci_core_subnet.FoggyKitchenClusterSubnet.id]

    add_ons {
      is_kubernetes_dashboard_enabled = true
      is_tiller_enabled               = true
    }

    kubernetes_network_config {
      pods_cidr     = var.cluster_options_kubernetes_network_config_pods_cidr
      services_cidr = var.cluster_options_kubernetes_network_config_services_cidr
    }
  }
}

locals {
  all_sources = data.oci_containerengine_node_pool_option.FoggyKitchenOKEClusterNodePoolOption.sources
  oracle_linux_images = [for source in local.all_sources : source.image_id if length(regexall("Oracle-Linux-[0-9]*.[0-9]*-20[0-9]*",source.source_name)) > 0]
}

resource "oci_containerengine_node_pool" "FoggyKitchenOKENodePool" {
  #depends_on = [oci_identity_policy.FoggyKitchenOKEPolicy1]
  cluster_id         = oci_containerengine_cluster.FoggyKitchenOKECluster.id
  compartment_id     = oci_identity_compartment.FoggyKitchenCompartment.id
  kubernetes_version = var.kubernetes_version
  name               = "FoggyKitchenOKENodePool"
  node_shape         = var.Shape
  
  node_source_details {
    image_id = local.oracle_linux_images.0
    source_type = "IMAGE"
  }

  node_shape_config {
    ocpus = 2
    memory_in_gbs = 40
  }

  node_config_details {
    size      = var.node_pool_size

    placement_configs {
      availability_domain = lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name")
      subnet_id           = oci_core_subnet.FoggyKitchenNodePoolSubnet.id
    }  
  }

  initial_node_labels {
    key   = "key"
    value = "value"
  }

  ssh_public_key      = file(var.public_key_oci)
}

