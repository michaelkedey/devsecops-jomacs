# Define a Docker image resource (e.g., nginx)
variable "image" {
  type    = string
  default = "michaelkedey/cipher-tool:v2"
}

variable "container_name" {
  default = "cipher-tool"
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