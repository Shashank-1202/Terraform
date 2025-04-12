variable "aws_vpc" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
  
}

variable "public_subnet_new" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
  
}

variable "private_subnet_new" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.2.0/24"
  
}