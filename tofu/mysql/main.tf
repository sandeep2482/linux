terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.6.2"
    }
  }
}

# Docker Provider using Default Socket
provider "docker" {}

# Docker Network for MySQL
resource "docker_network" "mysql_network" {
  name   = "mysql-network"
  driver = "bridge"
}

# MySQL Server Container
resource "docker_container" "mysql_server" {
  name  = "mysql-server"
  image = "mysql:latest"

  env = [
    "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}"
  ]

  networks_advanced {
    name = docker_network.mysql_network.name
  }

}

# MySQL Client Container with Interactive Bash
resource "docker_container" "mysql_client" {
  name  = "mysql-client"
  image = "mysql:latest"
  entrypoint = ["bash"]
  stdin_open = true  # Keeps stdin open for interaction
  networks_advanced {
    name = docker_network.mysql_network.name
  }

  depends_on = [docker_container.mysql_server]
}

# Define MySQL Root Password
variable "mysql_root_password" {
  description = "Root password for the MySQL server"
  default     = "Password1"
}

