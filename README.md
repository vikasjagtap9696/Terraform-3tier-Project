# Terraform 3-Tier AWS Infrastructure

This project provisions a modular three-tier AWS environment with Terraform:

- **Network:** VPC, public/private subnets, internet gateway, NAT gateway, routes, and tier-specific security groups
- **Web tier:** Public Application Load Balancer and web Auto Scaling Group
- **App tier:** Private Auto Scaling Group
- **Database tier:** Private, Multi-AZ MySQL RDS instance

## Architecture

```text
Internet
   |
Public Application Load Balancer
   |
Web Auto Scaling Group (public subnets)
   |
App Auto Scaling Group (private subnets)
   |
MySQL RDS (private subnets)
```

Public subnets use an internet gateway route. Private subnets use a NAT gateway
for outbound package downloads without being directly internet accessible.

The modules are organized as follows:

```text
.
├── backend.tf
├── main.tf
├── outputs.tf
├── variables.tf
├── terraform.tfvars
└── modules
    ├── app
    ├── db
    ├── network
    └── web
```

## Prerequisites

- Terraform `>= 1.5.0`
- AWS CLI configured with credentials that can create the required VPC, EC2, ELB, and RDS resources
- An existing S3 bucket for the remote state backend
- AMI IDs available in the selected AWS region

## Configuration

Edit `terraform.tfvars` before applying. The required values are:

```hcl
aws_region  = "ap-south-1"
web_ami_id  = "ami-xxxxxxxxxxxxxxxxx"
app_ami_id  = "ami-xxxxxxxxxxxxxxxxx"
db_username = "admin"
db_password = "replace-with-a-secret"
```

Network CIDRs, instance sizes, scaling limits, database size, Multi-AZ behavior, and backup retention are declared in `variables.tf` with safe defaults. The default RDS backup retention is `0` days for AWS Free Tier compatibility.

Do not commit real passwords or other credentials. Prefer an environment variable, a secrets manager, or a separate untracked `.tfvars` file for sensitive values.

## Usage

Initialize the providers and backend:

```powershell
terraform init
```

Format and validate the configuration:

```powershell
terraform fmt -recursive
terraform validate
```

Review the execution plan:

```powershell
terraform plan -var-file="terraform.tfvars"
```

Apply the infrastructure:

```powershell
terraform apply -var-file="terraform.tfvars"
```

Destroy the infrastructure when it is no longer needed:

```powershell
terraform destroy -var-file="terraform.tfvars"
```

## Outputs

- `web_alb_dns`: DNS name of the public Application Load Balancer
- `db_endpoint`: RDS database endpoint

## State backend

The S3 backend configuration is in `backend.tf`. The configured bucket must already exist and the AWS identity running Terraform must have access to the bucket and state key. Backend configuration cannot use normal Terraform input variables, so update the bucket, key, and region directly in `backend.tf` when deploying to another environment.
