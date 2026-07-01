output "web_container_name" {
  description = "Name of the web application container."
  value       = docker_container.web.name
}

output "web_image_name" {
  description = "Name of the web application Docker image."
  value       = docker_image.web.name
}