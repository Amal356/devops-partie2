terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Docker distant : la VM devopslab (= webserver, 192.168.56.81) via SSH par cle
provider "docker" {
  host     = "ssh://devops@devopslab:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx_remote" {
  image = docker_image.nginx.image_id
  name  = "nginx_terraform_remote"

  ports {
    internal = 80
    external = var.external_port
  }
}
