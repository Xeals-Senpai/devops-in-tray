resource "docker_image" "web" {
  name = "platforms-lab"

  build {
    context    = "${path.module}/../app"
    dockerfile = "Dockerfile"
  }
}

resource "docker_network" "platforms_lab" {
  name = "platforms-lab-network"
}

resource "docker_container" "web" {
  name  = "web-container"
  image = docker_image.web.name

  networks_advanced {
    name = docker_network.platforms_lab.name
  }

  ports {
    internal = 5050
    external = 5050
  }
}