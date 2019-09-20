module "sidecar_terminator" {
  source = "git::https://github.com/statcan/terraform-kubernetes-sidecar-terminator.git"

  dependencies = []

  kubectl_service_account = "tiller"
  kubectl_namespace = "kube-system"
}
