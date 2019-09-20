resource "null_resource" "label_ns_istio_system_control_plane" {

  provisioner "local-exec" {
    command = "kubectl label ns istio-system control-plane=true --overwrite"
  }
}
