locals {
  kubeconfig_yaml = base64decode(linode_lke_cluster.mgmt-cluster.kubeconfig)
  kubeconfig_hcl  = yamldecode(local.kubeconfig_yaml)
}