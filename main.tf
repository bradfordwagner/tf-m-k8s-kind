terraform {
  required_providers {
    kind = {
      source  = "justenwalker/kind"
      version = ">=0.17.0"
    }
  }
}

resource "kind_cluster" "cluster" {
  name   = var.name
  config = <<-EOF
    kind: Cluster
    apiVersion: kind.x-k8s.io/v1alpha4
    nodes:
    - role: control-plane
      image: ${var.k8s_image}
      extraPortMappings:
      %{for port_mapping in var.extra_port_mappings}
        - containerPort: ${port_mapping.container_port}
          hostPort: ${port_mapping.host_port}
          protocol: ${port_mapping.protocol}
      %{endfor~}
    EOF
  # want to take internal kubeconfig
  # parse server, ca
  # store in vault
  # then have it picked up during hydration
  provisioner "local-exec" {
    command = "${path.module}/extract_server_ca.sh"
    environment = {
      "cluster_name" = var.name
    }
  }
}
