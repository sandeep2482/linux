terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.6.2"
    }
  }
}

provider "docker" {}

resource "docker_service" "nginx_service" {
  name = "nginx-swarm-service"

  task_spec {
    container_spec {
      image = "nginx:latest"
    }
  }

  endpoint_spec {
    ports {
      protocol = "tcp"
      target_port = 80
      published_port = 8080
    }
  }

  mode {
    replicated {
      replicas = 3
    }
  }
}

