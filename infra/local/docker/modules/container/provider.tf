# Define the provider for Docker
# provider "docker" {
#   #host = "unix:///var/run/docker.sock"
#   host = "tcp://127.0.0.1:2376/"
# }


terraform {
 required_providers {

   docker = {
     source  = "kreuzwerker/docker"
     version = "3.0.2"
   }
 }
}
