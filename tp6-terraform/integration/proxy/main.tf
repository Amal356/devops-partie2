terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Defi : reverse proxy nginx (point d'entree unique) sur la VM control
provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx:alpine"
}

resource "docker_container" "proxy" {
  image   = docker_image.nginx.image_id
  name    = "cv_proxy"
  restart = "unless-stopped"

  ports {
    internal = 80
    external = 80
  }

  upload {
    file    = "/etc/nginx/conf.d/default.conf"
    content = file("${path.module}/nginx.conf")
  }
}
