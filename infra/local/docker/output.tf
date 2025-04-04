output "cipher_image_name" {
  value = module.docker_image-cipher-tool-v2.image_name
}

output "jomacsdevsecops_image_name" {
  value = module.docker_image-jomacsdevsecops-latest.image_name
}

output "cipher_container_link" {
  value = module.container-cipher.container_link
}
# output "jomacsdevsecops_container_link" {
#   value = module.container-jomacsdevsecops.container_link
# }