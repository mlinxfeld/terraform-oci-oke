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

output "FoggyKitchen_Cluster_Kubernetes_Versions" {
  value = [data.oci_containerengine_cluster_option.FoggyKitchenOKEClusterOption.kubernetes_versions]
}

output "FoggyKitchen_Cluster_NodePool_Kubernetes_Version" {
  value = [data.oci_containerengine_node_pool_option.FoggyKitchenOKEClusterNodePoolOption.kubernetes_versions]
}
