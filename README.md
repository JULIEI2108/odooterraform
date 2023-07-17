# odooterraform
This project is an automation script using Terraform for the Get2Know charity organization to deploy an Odoo server as a Docker container on an EC2 instance within AWS. This script not only deploys the EC2 instance, but also sets up a comprehensive network and monitoring infrastructure, including:

- Virtual Private Cloud (VPC)
- Public subnet
- EC2 instance
- CloudWatch alarm
- Docker engine installed on the EC2 instance
- Odoo server running as a Docker container
- SSL certificate for the domain
- Configured NGINX server

## Table of Contents
- [Prerequisites](#Prerequisites)
- [Installation](#installation)
- [Usage](#usage)

## Prerequisites
To work with this repository, you will need to meet the following prerequisites:

Git: Ensure that Git is installed on your machine. Git is a version control system used for managing and tracking changes to the project's source code.

Terraform CLI: Install the Terraform CLI (Command Line Interface) on your machine. Terraform is an infrastructure as code (IaC) tool used to provision and manage cloud resources.

AWS CLI: Install the AWS Command Line Interface (CLI) on your machine. The AWS CLI allows you to interact with various Amazon Web Services (AWS) from the command line.

AWS Credentials: Obtain valid AWS credentials, including an Access Key and Secret Access Key, which will authenticate and authorize access to your AWS account. Configure these credentials properly on your machine using the AWS CLI or environment variables.

Domain and IP Address: Ensure that you have a registered domain name and an associated IP address. Additionally, it is important that your current AWS account has control of this IP address. 

By meeting these prerequisites, you will have the necessary tools, credentials, and resources to work effectively with the repository and deploy infrastructure on AWS using Terraform.

## Installation

Instructions on how to install and set up the project.

```bash
# Clone the repository
git clone https://github.com/<your-username>/<project>.git

# Navigate to the project directory
cd <project>

# Initiate Terraform
terraform init

# Configure AWS CLI with your credentials
aws configure 


Please replace `<project>` and `<your-username>` with your actual project name and username. Make sure not to share your AWS credentials publicly.

```

## Usage

To use this project, follow the steps below:
1.Locate the following variable configuration in the Terraform code:

```hcl
variable "EBS_size" {
  type    = number
  default = 16

}

variable "instance_type" {
  type    = string
  default = "t2.small"
}

variable "certbot_cert" {
  type = map(any)
  default = {
    "<domain1>" = "<email1>"
    "<domain2>" = "<email2>"
  }
}
```

Replace <domain1> and <domain2> with your domain and <email1> with your email address. Change EBS size or instance_type if required

2.
```bash
#Run the following command to validate the Terraform script:
terraform validate

#if the script is valid, run the following command to apply the changes:
terraform apply
```
Terraform will prompt you for inputs such as IP address and server name. Please provide the required inputs.

You will be asked if you want to deploy the changes on AWS. Type yes and press Enter to proceed with the deployment.

It will take about 5 minutes to deploy the infrastructure. Once the deployment is completed, you should be able to visit Odoo through the URL https://<your-domain>











