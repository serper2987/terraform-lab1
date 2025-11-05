# Variables para configuración de Nginx
variable "nginx_container_name" {
  description = "Nombre del contenedor Nginx"
  type        = string
  default     = "tutorial-nginx"
}

variable "nginx_external_port" {
  description = "Puerto externo para el contenedor Nginx"
  type        = number
  default     = 8000
}

variable "nginx_internal_port" {
  description = "Puerto interno del contenedor Nginx"
  type        = number
  default     = 80
}

# Variables para configuración de MySQL
variable "mysql_container_name" {
  description = "Nombre del contenedor MySQL"
  type        = string
  default     = "tutorial-mysql"
}

variable "mysql_external_port" {
  description = "Puerto externo para el contenedor MySQL"
  type        = number
  default     = 3306
}

variable "mysql_internal_port" {
  description = "Puerto interno del contenedor MySQL"
  type        = number
  default     = 3306
}

variable "mysql_root_password" {
  description = "Contraseña root para MySQL"
  type        = string
  default     = "rootpassword"
  sensitive   = true
}

variable "mysql_database" {
  description = "Nombre de la base de datos a crear"
  type        = string
  default     = "tutorial_db"
}

variable "mysql_user" {
  description = "Usuario de la base de datos"
  type        = string
  default     = "tutorial_user"
}

variable "mysql_password" {
  description = "Contraseña del usuario de la base de datos"
  type        = string
  default     = "userpassword"
  sensitive   = true
}

# Variables generales
variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  default     = "development"
}