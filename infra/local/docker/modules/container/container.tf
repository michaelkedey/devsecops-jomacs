# Define a Docker container using the image
resource "docker_container" "container" {
  name           = var.container_name
  image          = var.image
  remove_volumes = true

  ports {
    internal = var.ports.internal_port
    external = var.ports.external_port
    ip       = var.ports.container_ip
    protocol = var.ports.container_protocol

  }
}
