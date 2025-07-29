terraform {
    required_providers {
        docker= {
            source= "kreuzwerker/docker"
            version= "~> 3.0"
        }
    }
    backend "local" {}
}
provider "docker" {}
resource "docker_image" "web" {
  name = "devops-in-tray"
  build {
    context    = "${path.module}/../app"
    dockerfile = "Dockerfile"
  }
}
resource "docker_container" "web" {
  name  = "web-container"
  image = docker_image.web.latest
  ports {
    internal = 5000
    external = 5000
  }
}