# odooterraform
This is an automation terraform script for get2know charity to deploy odoo server as docker on a EC2 instance on AWS. 
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

By meeting these prerequisites, you will have the necessary tools, credentials, and resources to work effectively with the repository and deploy infrastructure on AWS 
using Terraform.

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

## usage

To use this project, follow the steps below:

