variable "availability_zones" {
  description = "Availability zones in this region to use"
  default     = ["eu-central-1a", "eu-central-1b"]
  type        = list(string)
}

/* variable "subnet_cidrs_public" {
  default = ["10.0.1.0/24", "10.0.3.0/24"]
  type    = list(string)
}

variable "subnet_cidrs_private" {
  default = ["10.0.2.0/24", "10.0.4.0/24"]
  type    = list(string)
} */

variable "subnet_cidrs_public" {
  default = ["192.168.0.0/18", "192.168.64.0/18"]
  type    = list(string)
}

variable "subnet_cidrs_private" {
  default = ["192.168.128.0/18", "192.168.192.0/18"]
  type    = list(string)
}

variable "master_instance_count" {
  description = "Number of master instances in cluster"
  type        = number
  default     = 1
}

variable "worker_instance_count" {
  description = "Number of worker instances in cluster"
  type        = number
  default     = 2
}