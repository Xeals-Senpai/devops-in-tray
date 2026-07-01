# terraform/variables.tf

variable "project_name" {
  description = "Name used for local Docker resources."
  type        = string
  default     = "platforms-lab"
}