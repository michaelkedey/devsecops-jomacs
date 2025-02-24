output "container_link" {
  value = "http://localhost:${docker_container.container.ports[0].external}"
}
