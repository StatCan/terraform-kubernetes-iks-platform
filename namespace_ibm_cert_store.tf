resource "null_resource" "label_ns_ibm_cert_store_control_plane" {

  provisioner "local-exec" {
    command = "kubectl label ns ibm-cert-store control-plane=true --overwrite"
  }
}
