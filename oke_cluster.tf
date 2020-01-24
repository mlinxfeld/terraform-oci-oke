
resource "oci_containerengine_cluster" "FoggyKitchenOKECluster" {
  #depends_on = [oci_identity_policy.FoggyKitchenOKEPolicy1]
  compartment_id     = oci_identity_compartment.FoggyKitchenCompartment.id
  kubernetes_version = data.oci_containerengine_cluster_option.FoggyKitchenOKEClusterOption.kubernetes_versions.0
  name               = var.ClusterName
  vcn_id             = oci_core_vcn.FoggyKitchenVCN.id

  options {
    service_lb_subnet_ids = [oci_core_subnet.FoggyKitchenClusterSubnet1.id, oci_core_subnet.FoggyKitchenClusterSubnet2.id]

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

resource "oci_containerengine_node_pool" "FoggyKitchenOKENodePool" {
  #depends_on = [oci_identity_policy.FoggyKitchenOKEPolicy1]
  cluster_id         = oci_containerengine_cluster.FoggyKitchenOKECluster.id
  compartment_id     = oci_identity_compartment.FoggyKitchenCompartment.id
  kubernetes_version = data.oci_containerengine_node_pool_option.FoggyKitchenOKEClusterNodePoolOption.kubernetes_versions.0
  name               = "FoggyKitchenOKENodePool"
  node_image_name    = var.Images[0]
  node_shape         = var.Shapes[0]
  subnet_ids         = [oci_core_subnet.FoggyKitchenNodePoolSubnet1.id,oci_core_subnet.FoggyKitchenNodePoolSubnet2.id]

  initial_node_labels {
    key   = "key"
    value = "value"
  }

  quantity_per_subnet = var.node_pool_quantity_per_subnet
  ssh_public_key      = file(var.public_key_oci)
}

output "FoggyKitchenOKECluster" {
  value = {
    id                 = oci_containerengine_cluster.FoggyKitchenOKECluster.id
    kubernetes_version = oci_containerengine_cluster.FoggyKitchenOKECluster.kubernetes_version
    name               = oci_containerengine_cluster.FoggyKitchenOKECluster.name
  }
}

output "FoggyKitchenOKENodePool" {
  value = {
    id                 = oci_containerengine_node_pool.FoggyKitchenOKENodePool.id
    kubernetes_version = oci_containerengine_node_pool.FoggyKitchenOKENodePool.kubernetes_version
    name               = oci_containerengine_node_pool.FoggyKitchenOKENodePool.name
    subnet_ids         = oci_containerengine_node_pool.FoggyKitchenOKENodePool.subnet_ids
  }
}
