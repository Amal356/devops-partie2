variable "cv_image" {
  description = "Image Docker du CV publiee sur Docker Hub"
  type        = string
  default     = "amal878/cv-onepage:1.0"
}

variable "external_port" {
  description = "Port de la VM expose vers le port 80 du conteneur CV"
  type        = number
  default     = 8001
}

variable "cv_host" {
  description = "Nom de la VM affiche dans la page"
  type        = string
  default     = "vm"
}
