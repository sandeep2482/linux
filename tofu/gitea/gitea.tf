terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.6.2"
    }
  }
}

provider "docker" {}

# Create a Docker volume for persistent Gitea storage
resource "docker_volume" "gitea_data" {
  name = "gitea-data"
}

# Run the Gitea container
resource "docker_container" "gitea" {
  name  = "gitea"
  image = "gitea/gitea:latest"

  ports {
    internal = 3000
    external = 3000
  }

  ports {
    internal = 22
    external = 222
  }

  volumes {
    volume_name = docker_volume.gitea_data.name
    container_path = "/data"
  }

  restart = "always"
}

