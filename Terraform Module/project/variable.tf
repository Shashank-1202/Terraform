variable "vpc_name" {
  description = "my vpc name"   
    type        = string
}

variable "vpc_cidr" {
    description = "this is vpc cidr block"
    type        = string  
}

variable "public_cidr" {
   description = "This is public_cidr"
   type = string  
}

variable "instance_type" {
   description = "this is instance type"
   type = string  
}