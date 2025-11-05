terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

# Red personalizada para la comunicación entre contenedores
resource "docker_network" "tutorial_network" {
  name = "tutorial-network"
}

# Imagen MySQL
resource "docker_image" "mysql" {
  name         = "mysql:8.0"
  keep_locally = false
}

# Contenedor MySQL
resource "docker_container" "database" {
  image = docker_image.mysql.image_id
  name  = var.mysql_container_name
  
  networks_advanced {
    name = docker_network.tutorial_network.name
    aliases = ["mysql-server"]
  }
  
  ports {
    internal = var.mysql_internal_port
    external = var.mysql_external_port
  }
  
  env = [
    "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}",
    "MYSQL_DATABASE=${var.mysql_database}",
    "MYSQL_USER=${var.mysql_user}",
    "MYSQL_PASSWORD=${var.mysql_password}"
  ]
  
  # Configuración de salud para MySQL
  healthcheck {
    test     = ["CMD", "mysqladmin", "ping", "-h", "localhost"]
    interval = "10s"
    timeout  = "5s"
    retries  = 5
  }
}

# Imagen Nginx
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# Contenedor Nginx (depende de MySQL)
resource "docker_container" "web" {
  image = docker_image.nginx.image_id
  name  = var.nginx_container_name
  
  networks_advanced {
    name = docker_network.tutorial_network.name
    aliases = ["web-server"]
  }
  
  ports {
    internal = var.nginx_internal_port
    external = var.nginx_external_port
  }
  
  # Etiquetas para identificar el entorno
  labels {
    label = "environment"
    value = var.environment
  }
  
  labels {
    label = "project"
    value = "terraform-lab1"
  }
  
  # Dependencia explícita: Nginx debe esperar a que MySQL esté listo
  depends_on = [docker_container.database]
}
