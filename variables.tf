variable "name" {
  type = string
}

variable "extra_port_mappings" {
  default = []
  type = list(object({
    host_port      = number
    container_port = number
    protocol       = string # TCP
  }))
}
