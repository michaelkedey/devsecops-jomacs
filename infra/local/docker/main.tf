module "docker_image" {
  source = "./modules/image"
  image  = var.image

}

module "container" {
  source         = "./modules/container"
  container_name = var.container_name
  image          = module.docker_image.image_name
  depends_on     = [module.docker_image]
}
