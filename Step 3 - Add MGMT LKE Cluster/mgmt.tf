resource "linode_lke_cluster" "mgmt-cluster" {
    label       = "mgmt-cluster"
    k8s_version = "1.31"
    region      = "de-fra-2"
    tags        = ["workshop"]

    pool {
        type  = "g6-standard-2"
        count = 3
    }
}