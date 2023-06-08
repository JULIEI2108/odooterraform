variable "aws_region" {
  type    = string
  default = "ap-southeast-2"
}

variable "vpc_name" {
  type    = string
  default = "odoovpc"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/20"
}


variable "public_sub_cidr" {
  description = "CIDR Block for the Variables Subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "variables_sub_auto_ip" {
  description = "Set Automatic IP Assigment for Variables Subnet"
  type        = bool
  default     = true
}

variable "AMI" {
  description = "odoo AMI template"
  default     = "ami-01dd374d2e357acd5"
}
