variable "cluster_kube_config_token_version" {
  default = "2.0.0"
}

data "oci_containerengine_cluster_kube_config" "FoggyKitchenKubeConfig" {
  cluster_id = oci_containerengine_cluster.FoggyKitchenOKECluster.id

  #Optional
  token_version = var.cluster_kube_config_token_version
}

resource "local_file" "FoggyKitchenKubeConfigFile" {
  content  = data.oci_containerengine_cluster_kube_config.FoggyKitchenKubeConfig.content
  filename = "test_cluster_kubeconfig"
}
