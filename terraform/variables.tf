variable "instance_count" {
  type        = number
  description = "Number of benchmarking client instances"
  default     = 1
}

variable "instance_type" {
  type        = string
  description = "Type of benchmarking client instances"
  default     = "e2-micro"
}

variable "instance_region" {
  type        = string
  description = "Region of benchmarking client instances"
  default     = "europe-west3-a"
}

variable "target_function_endpoint" {
  type        = string
  description = "Function to send requests against."
  default     = ""
}

variable "ssh_user" {
  type        = string
  description = "User for ssh access."
  default     = "provisioner"
}

variable "ssh_key_path_private" {
  type        = string
  description = "Path to private SSH key"
  default     = "./benchmark"
}

variable "ssh_key_path_public" {
  type        = string
  description = "Path to public SSH key"
  default     = "./benchmark.pub"
}

