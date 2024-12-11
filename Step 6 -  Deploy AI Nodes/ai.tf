resource "linode_instance" "k3s-ai" {
  for_each = toset(var.specified_regions)
  label     = "${var.userid}-ai-${each.key}"
  region    = each.key
  image     = "linode/ubuntu22.04"
  type      = "g6-standard-2"
  root_pass = "Terr4form-test!" # Ensure this is a secure password
  tags      = ["app:ai"]

  metadata {
    user_data = base64encode(file("./yaml/ai.yaml"))
  }
}