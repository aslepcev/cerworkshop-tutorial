resource "linode_instance" "k3s-hdb" {
  for_each = toset(var.specified_regions)
  label     = "${var.userid}-hdb-${each.key}"
  region    = each.key
  image     = "linode/ubuntu24.04"
  type      = "g6-standard-2"
  root_pass = "Terr4form-test!" # Ensure this is a secure password
  tags      = ["app:harperdb-${each.key}"]

  metadata {
    user_data = base64encode(templatefile("./yaml/hdb.tpl", {
    clustering_nodename = each.key
  }))
 }
}