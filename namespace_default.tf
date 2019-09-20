module "namespace_default" {
  source = "git::https://github.com/statcan/terraform-kubernetes-namespace.git"

  name = "default"
  namespace_admins = {
    users = "${var.kubernetes_rbac_users}"
    groups = "${var.kubernetes_rbac_groups}"
  }

  # ServiceAccount
  helm_service_account = "tiller"

  # CICD
  ci_name = "argo"

  # Image Pull Secret
  # enable_kubernetes_secret = "${var.enable_kubernetes_secret}"
  # kubernetes_secret = "${var.kubernetes_secret}"
  # docker_repo = "${var.docker_repo}"
  # docker_username = "${var.docker_username}"
  # docker_password = "${var.docker_password}"
  # docker_email = "${var.docker_email}"
  # docker_auth = "${var.docker_auth}"

  dependencies = []
}


resource "null_resource" "label_ns_default_istio_injection" {

  provisioner "local-exec" {
    command = "kubectl label ns default istio-injection=enabled --overwrite"
  }
}
