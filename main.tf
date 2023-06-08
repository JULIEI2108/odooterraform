terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}
data "aws_availability_zones" "available" {}
data "aws_region" "current" {}

# Configure the AWS Provider
provider "aws" {
  profile = "odooCredential"
  region  = "ap-southeast-2"
}

resource "aws_vpc" "odoovpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = var.vpc_name
    Environment = "demo_environment"
    Terraform   = "true"
    Region      = data.aws_region.current.name
  }
}

resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.odoovpc.id
  cidr_block              = var.public_sub_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name      = "odooSubnet"
    Terraform = "true"
  }
}

resource "aws_eip" "odooIP" {
  domain = "vpc"
}

resource "aws_eip_association" "odooIP" {
  instance_id   = aws_instance.odooERP.id
  allocation_id = aws_eip.odooIP.id
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.odoovpc.id
  tags = {
    Name = "odoo_igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.odoovpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
    #nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name      = "odoo_public_rtb"
    Terraform = "true"
  }
}

resource "aws_route_table_association" "public" {
  depends_on     = [aws_subnet.public_subnets]
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnets.id
}

resource "aws_instance" "odooERP" {
  ami           = var.AMI
  instance_type = "t2.micro"

  subnet_id              = aws_subnet.public_subnets.id
  vpc_security_group_ids = [aws_security_group.ingress-ssh.id, aws_security_group.odoo_web.id]
  tags = {
    "Terraform" = "true"
  }
}


resource "aws_security_group" "ingress-ssh" {
  name   = "allow-all-ssh"
  vpc_id = aws_vpc.odoovpc.id
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "odoo_web" {
  name        = "odoo-web-traffic"
  vpc_id      = aws_vpc.odoovpc.id
  description = "Web Traffic"
  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_cloudwatch_metric_alarm" "alarm_for_odooserver" {
  alarm_name                = "alarm_for_odooserver"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  metric_name               = "StatusCheckFailed_System"
  namespace                 = "AWS/EC2"
  period                    = 60
  statistic                 = "Average"
  threshold                 = 0.99
  alarm_description         = "StatusCheckFailed_System"
  insufficient_data_actions = [aws_sns_topic.alarm_updates.arn]
  alarm_actions             = [aws_sns_topic.alarm_updates.arn, aws_instance.odooERP.id]

}

resource "aws_sns_topic" "alarm_updates" {
  name = "alarm_updates-topic"
}

# module "autoscaling" {
#   source  = "terraform-aws-modules/autoscaling/aws"
#   version = "6.10.0"
#   name = "odoo autogroup"
#   availability_zones = [aws_subnet.public_subnets.id]
#   image_id = var.AMI.default
#     min_size = 0
#   max_size = 1
#   desired_capacity = 1
#   instance_type = "t2.micro"
#     tags = {
#     Name = "odooServer"
#   }
#   security_groups = [aws_security_group.ingress-ssh.id, aws_security_group.odoo_web.id]
# }