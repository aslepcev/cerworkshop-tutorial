resource "helm_release" "argocd" {
  depends_on = [ linode_lke_cluster.mgmt-cluster ]
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
}