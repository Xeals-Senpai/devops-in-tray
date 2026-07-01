resource "docker_image" "web" {
  name = "platforms-lab"

  build {
    context    = "${path.module}/../app"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "web" {
  name  = "web-container"
  image = docker_image.web.name

  ports {
    internal = 5000
    external = 5000
  }
}