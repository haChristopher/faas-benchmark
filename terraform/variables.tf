variable "instance_count" {
  type        = number
  description = "Number of benchmarking client instances"
  default     = 1
}

variable "instance_type" {
  type        = string
  description = "Type of benchmarking client instances"
  default     = "f1.micro"
}

variable "instance_region" {
  type        = string
  description = "Region of benchmarking client instances"
  default     = "europe-west3-a"
}
