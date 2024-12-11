terraform {
  required_providers {
    linode = {
      source = "linode/linode"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.16.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.23.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

# Configure the Linode Provider
provider "linode" {
  token = var.linode_token
}

provider "kubernetes" {
  host                   = local.kubeconfig_hcl.clusters[0].cluster.server
  token                  = local.kubeconfig_hcl.users[0].user.token
  cluster_ca_certificate = base64decode(local.kubeconfig_hcl.clusters[0].cluster.certificate-authority-data)
}


# Configure the Helm Provider
provider "helm" {
  kubernetes {
    host                   = local.kubeconfig_hcl.clusters[0].cluster.server
    token                  = local.kubeconfig_hcl.users[0].user.token
    cluster_ca_certificate = base64decode(local.kubeconfig_hcl.clusters[0].cluster.certificate-authority-data)
  }
}

provider "kubectl" {
  host                   = local.kubeconfig_hcl.clusters[0].cluster.server
  cluster_ca_certificate = base64decode(local.kubeconfig_hcl.clusters[0].cluster.certificate-authority-data)
  token                  = local.kubeconfig_hcl.users[0].user.token
  load_config_file       = false
}