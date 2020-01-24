data "oci_containerengine_cluster_option" "FoggyKitchenOKEClusterOption" {
  cluster_option_id = "all"
}

data "oci_containerengine_node_pool_option" "FoggyKitchenOKEClusterNodePoolOption" {
  node_pool_option_id = "all"
}

output "FoggyKitchen_Cluster_Kubernetes_Versions" {
  value = [data.oci_containerengine_cluster_option.FoggyKitchenOKEClusterOption.kubernetes_versions]
}

output "FoggyKitchen_Cluster_NodePool_Kubernetes_Version" {
  value = [data.oci_containerengine_node_pool_option.FoggyKitchenOKEClusterNodePoolOption.kubernetes_versions]
}
