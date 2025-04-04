# Define a Docker image resource (e.g., nginx)
variable "cipher-image" {
  type    = string
  default = "michaelkedey/cipher-tool:v2"
}

variable "jomacsdevsecops-image" {
  type    = string
  default = "michaelkedey/jomacsdevsecops:latest"
}

variable "container_name_cipher" {
  default = "cipher-tool"
  type    = string
}

variable "container_name_jomacsdevsecops" {
  default = "jomacsdevsecops"
  type    = string
}
variable "ports" {
  type = map(string)
  default = {
    internal_port_jomacsdevsecops = 80
    external_port_jomacsdevsecops = 80
    container_ip                  = "0.0.0.0"
    container_protocol            = "tcp"
  }
}




