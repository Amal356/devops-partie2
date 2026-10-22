terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "cv" {
  name = var.cv_image
}

resource "docker_container" "cv" {
  image   = docker_image.cv.image_id
  name    = "cv"
  restart = "unless-stopped"
  env     = ["CV_HOST=${var.cv_host}:${var.external_port}"]

  ports {
    internal = 80
    external = var.external_port
  }
}
