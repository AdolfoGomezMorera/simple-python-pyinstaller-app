provider "docker" {}

resource "docker_network" "jenkins_net" {
  name = "jenkins_net"
}

resource "docker_image" "jenkins_custom" {
  name = "jenkins_custom:latest"
  build {
    context    = "${path.module}"
    dockerfile = "${path.module}/Dockerfile"
  }
}

resource "docker_container" "jenkins" {
  name  = "jenkins"
  image = docker_image.jenkins_custom.name

  networks_advanced {
    name = docker_network.jenkins_net.name
  }

  ports {
    internal = 8080
    external = 8080
  }

  ports {
    internal = 50000
    external = 50000
  }

  volumes {
    container_path = "/var/jenkins_home"
    host_path      = "${path.module}/jenkins_home"
  }

  depends_on = [docker_image.jenkins_custom]
}

resource "docker_container" "dind" {
  name  = "docker-in-docker"
  image = "docker:dind"

  privileged = true

  networks_advanced {
    name = docker_network.jenkins_net.name
  }

  ports {
    internal = 2375
    external = 2375
  }

  command = ["--host=tcp://0.0.0.0:2375", "--host=unix:///var/run/docker.sock"]
}

# Output para mostrar la URL de Jenkins
output "jenkins_url" {
  value = "http://localhost:8080"
}

