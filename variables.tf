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

variable "elastic_ip" {
  description = "Set ip address for instance"
  type        = string
}

variable "AMI" {
  description = "odoo AMI template"
  default     = "ami-0310483fb2b488153"
}



variable "EBS_size" {
  type    = number
  default = 16

}

variable "instance_type" {
  type    = string
  default = "t2.small"
}

variable "server_name" {
  type        = string
  description = "Enter server name"
}

variable "certbot_cert" {
  type = map(any)
  default = {
    "younglogix.com.au"    = "julie.jin@get2know.org.au"
    "spotter.foodgola.com" = "julie.jin@get2know.org.au"
    "choise.com.au"        = "julie.jin@get2know.org.au"
  }
}

