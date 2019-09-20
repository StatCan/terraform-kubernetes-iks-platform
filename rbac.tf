# Tiller role

resource "kubernetes_cluster_role" "tiller" {
  metadata {
    name = "tiller"
  }

  rule {
    api_groups = [
      "",
      "extensions",
      "apps",
      "batch",
      "policy",
      "admissionregistration.k8s.io",
      "rbac.authorization.k8s.io",
      "apiextensions.k8s.io",
      "apiregistration.k8s.io",
      "networking.k8s.io",
      "networking.istio.io",
      "authentication.istio.io",
      "config.istio.io",
      "monitoring.coreos.com",
      "certmanager.k8s.io"
    ]
    resources = ["*"]
    verbs = ["*"]
  }
}

# Permissions

resource "kubernetes_cluster_role_binding" "cluster-admin" {
  metadata {
    name = "k8s-cluster-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "ClusterRole"
    name = "cluster-admin"
  }

  dynamic "subject" {
    for_each = "${var.kubernetes_rbac_users}"

    content {
      api_group = "rbac.authorization.k8s.io"
      kind = "User"
      name = "${subject.value}"
    }
  }

  dynamic "subject" {
    for_each = "${var.kubernetes_rbac_groups}"

    content {
      api_group = "rbac.authorization.k8s.io"
      kind = "Group"
      name = "${subject.value}"
    }
  }
}

resource "kubernetes_cluster_role" "cluster-user" {
  metadata {
    name = "cluster-user"
  }

  # Read-only access to namespaces and nodes
  rule {
    api_groups = [""]
    resources = ["namespaces", "nodes"]
    verbs = ["list", "get", "watch"]
  }
}

# Namespace admin role
resource "kubernetes_role" "dashboard-user" {
  metadata {
    name = "dashboard-user"
    namespace = "kube-system"
  }

  # Read-only access to resource quotas
  rule {
    api_groups = [""]
    resources = ["services/proxy"]
    resource_names = ["https:kubernetes-dashboard:"]
    verbs = ["get", "create"]
  }
}
