resource "linode_instance" "k3s-frontend" {
  for_each = toset(var.specified_regions)

  label     = "${var.userid}-frontend-${each.key}"
  region    = each.key
  image     = "linode/ubuntu24.04"
  type      = "g6-standard-2"
  root_pass = "Terr4form-test!" # Ensure this is a secure password
  tags      = ["app:frontend"]

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