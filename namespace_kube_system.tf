resource "null_resource" "label_ns_kube_system_control_plane" {

  provisioner "local-exec" {
    command = "kubectl label ns kube-system control-plane=true --overwrite"
  }
}
