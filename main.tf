terraform {
  required_providers {
    kind = {
      source  = "justenwalker/kind"
      version = "0.17.0"
    }
  }
}

resource "kind_cluster" "cluster" {
  name   = "test"
  config = <<-EOF
    kind: Cluster
    apiVersion: kind.x-k8s.io/v1alpha4
    nodes:
    - role: control-plane
  EOF
}
