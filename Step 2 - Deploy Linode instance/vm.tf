resource "linode_instance" "k3s-api" {
  label     = "cerworkshop"
  region    = "de-fra-2"
  image     = "linode/ubuntu24.04"
  type      = "g6-standard-2"
  root_pass = "Terr4form-test!" # Ensure this is a secure password
  tags      = ["app:cerworkshop"]
}