resource "null_resource" "label_ns_kube_node_lease_control_plane" {

  provisioner "local-exec" {
    command = "kubectl label ns kube-node-lease control-plane=true --overwrite"
  }
}
