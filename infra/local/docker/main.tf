module "docker_image-cipher-tool-v2" {
  source = "./modules/image"
  image  = var.cipher-image
}

module "docker_image-jomacsdevsecops-latest" {
  source = "./modules/image"
  image  = var.jomacsdevsecops-image
}

module "container-cipher" {
  source         = "./modules/container"
  container_name = var.container_name_cipher
  image          = module.docker_image-cipher-tool-v2.image_name
  depends_on     = [module.docker_image-cipher-tool-v2]
}

# module "container-jomacsdevsecops" {
#   source         = "./modules/container"
#   container_name = var.container_name_jomacsdevsecops
#   image          = module.docker_image-jomacsdevsecops-latest.image_name
#   depends_on     = [module.docker_image-jomacsdevsecops-latest]
#   ports = {
#     internal = var.ports.internal_port_jomacsdevsecops
#     external = var.ports.external_port_jomacsdevsecops
#   }
# }
