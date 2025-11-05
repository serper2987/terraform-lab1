# Outputs para el contenedor Nginx
output "nginx_container_id" {
  description = "ID del contenedor Nginx"
  value       = docker_container.web.id
}

output "nginx_container_name" {
  description = "Nombre del contenedor Nginx"
  value       = docker_container.web.name
}

output "nginx_external_port" {
  description = "Puerto externo del contenedor Nginx"
  value       = var.nginx_external_port
}

output "nginx_url" {
  description = "URL para acceder al servidor Nginx"
  value       = "http://localhost:${var.nginx_external_port}"
}

# Outputs para el contenedor MySQL
output "mysql_container_id" {
  description = "ID del contenedor MySQL"
  value       = docker_container.database.id
}

output "mysql_container_name" {
  description = "Nombre del contenedor MySQL"
  value       = docker_container.database.name
}

output "mysql_external_port" {
  description = "Puerto externo del contenedor MySQL"
  value       = var.mysql_external_port
}

output "mysql_connection_string" {
  description = "Cadena de conexión para MySQL"
  value       = "mysql://${var.mysql_user}:${var.mysql_password}@localhost:${var.mysql_external_port}/${var.mysql_database}"
  sensitive   = true
}

# Outputs generales
output "environment" {
  description = "Entorno de despliegue"
  value       = var.environment
}

output "containers_info" {
  description = "Información resumida de todos los contenedores"
  value = {
    nginx = {
      name = docker_container.web.name
      port = var.nginx_external_port
      url  = "http://localhost:${var.nginx_external_port}"
    }
    mysql = {
      name     = docker_container.database.name
      port     = var.mysql_external_port
      database = var.mysql_database
    }
  }
}