terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.15.0"
    }
  }
}

provider "docker" {}

variable "container_name" {
  description = "Value of the name for the docker"
  type        = string
  default     = "ExampleNginx"
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  #name  = "tutorial"
  name = var.container_name
  ports {
    internal = 80
    external = 8050
  }
}

output "container_id" {
  value = docker_container.nginx.id
}
