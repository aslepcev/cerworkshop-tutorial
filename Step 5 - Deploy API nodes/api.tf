

resource "linode_instance" "vm" {
  label     = "cerworkshop"
  region    = "de-fra-2"
  image     = "linode/ubuntu24.04"
  type      = "g6-standard-2"
  root_pass = "Terr4form-test!" # Ensure this is a secure password
  tags      = ["app:cerworkshop"]
}

VS

resource "linode_instance" "k3s-api" {
  for_each = toset(var.specified_regions)
  label     = "${var.userid}-api-${each.key}"
  region    = each.key
  image     = "linode/ubuntu24.04"
  type      = "g6-standard-2"
  root_pass = "Terr4form-test!" # Ensure this is a secure password
  tags      = ["app:api"]

  metadata {
    user_data = base64encode(file("./yaml/k3s.yaml"))
  }

  provisioner "local-exec" {
    command = <<EOT
      sleep 90
      sshpass -p "Terr4form-test!" scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@${self.ip_address}:/root/.kube/${self.label} ./${self.label}
    EOT
  }
}










