variable "container_name" {
  default = "docker-container"
  type    = string
}

variable "ports" {
  type = map(string)
  default = {
    internal_port      = 5000
    external_port      = 5000
    container_ip       = "0.0.0.0"
    container_protocol = "tcp"
  }
}

variable "image" {
  type = string
}