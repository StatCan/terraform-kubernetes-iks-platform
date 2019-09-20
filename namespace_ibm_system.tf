resource "null_resource" "label_ns_ibm_system_control_plane" {

  provisioner "local-exec" {
    command = "kubectl label ns ibm-system control-plane=true --overwrite"
  }
}

resource "null_resource" "configure_istio_mtls" {

  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/config/istio-mtls.yml"
  }
}

resource "null_resource" "configure_istio_ingress_gateway" {

  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/config/istio-ingress-gateway.yml"
  }
}
