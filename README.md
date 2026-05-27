# Production-Style AWS Infrastructure Automation Using Terraform

## Project Overview

This project provisions a production-style AWS cloud infrastructure using Terraform Infrastructure as Code (IaC).

The infrastructure is designed to host containerized applications using Amazon ECS with an Application Load Balancer, Auto Scaling, private networking, and PostgreSQL RDS deployment.

The project demonstrates real-world DevOps and cloud engineering concepts including:

- Infrastructure as Code (Terraform)
- AWS networking
- ECS container orchestration
- Application Load Balancer configuration
- Auto Scaling
- Security Groups
- CloudWatch monitoring
- Highly available architecture
- Public and private subnet design

---

# Architecture

## Infrastructure Components

- VPC
- Public Subnets
- Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- ECS Cluster
- ECS Task Definitions
- ECS Services
- Launch Templates
- Auto Scaling Groups
- Application Load Balancer
- Target Groups
- PostgreSQL RDS
- CloudWatch Logs

---

# Architecture Flow

```text
Internet
    ↓
Application Load Balancer (Public Subnets)
    ↓
Target Group
    ↓
ECS Services / ECS Tasks (Private Subnets)
    ↓
PostgreSQL RDS (Private Subnets)
AWS Services Used
Service	Purpose
VPC	Private cloud network
ECS	Container orchestration
EC2	ECS worker nodes
ALB	Traffic distribution
Auto Scaling Group	Automatic EC2 scaling
RDS PostgreSQL	Managed relational database
IAM	Access management
CloudWatch	Logging and monitoring
NAT Gateway	Internet access for private subnets
Project Structure
AWS-infrastructure-automation-terraform/
│
├── provider.tf
├── versions.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
│
├── vpc.tf
├── subnets.tf
├── internet-gateway.tf
├── nat-gateway.tf
├── route-tables.tf
│
├── security-groups.tf
├── iam.tf
│
├── alb.tf
├── target-groups.tf
│
├── ecs.tf
├── ecs-service.tf
├── ecs-task-definition.tf
├── launch-template.tf
├── autoscaling.tf
│
├── rds.tf
├── monitoring.tf
│
├── userdata.sh
├── .gitignore
│
└── README.md
Features
Networking
Custom VPC using CIDR block 10.0.0.0/16
Public and private subnet architecture
Internet Gateway for public internet access
NAT Gateway for secure outbound internet access from private subnets
Security
Security Groups implementing least privilege access
ECS instances accessible only through ALB
PostgreSQL accessible only from ECS containers
Sensitive variables separated using Terraform variables
ECS Infrastructure
ECS Cluster using EC2 launch type
ECS Task Definitions
ECS Services
Launch Templates
Auto Scaling Groups
Load Balancing
Internet-facing Application Load Balancer
Target Groups for ECS containers
Listener rules for traffic forwarding
Database
PostgreSQL RDS instance deployed in private subnets
Secure database access
Isolated networking design
Monitoring
CloudWatch Log Groups
Infrastructure logging support
Prerequisites

Before running this project, ensure you have:

AWS Account
Terraform >= 1.5
AWS CLI configured
IAM permissions for AWS resource provisioning
Git installed
Configure AWS CLI
aws configure

Provide:

AWS Access Key
AWS Secret Key
Default Region
Output Format
Terraform Workflow
Initialize Terraform
terraform init
Validate Configuration
terraform validate
Preview Infrastructure Changes
terraform plan
Deploy Infrastructure
terraform apply
Destroy Infrastructure
terraform destroy
Security Best Practices
Important

This project excludes sensitive files using .gitignore.

Ignored files include:

*.tfvars
*.tfstate
*.tfstate.backup
.terraform/
Notes
ECS instances run inside private subnets
ALB runs inside public subnets
NAT Gateway enables outbound internet access for ECS instances
RDS is not publicly accessible
Future Improvements

Potential production improvements:

HTTPS using ACM certificates
Route53 DNS integration
ECS Fargate migration
Terraform modules
Remote Terraform state backend (S3 + DynamoDB)
CI/CD pipeline integration
CloudWatch alarms
Multi-AZ NAT Gateway deployment
Secrets Manager integration
Skills Demonstrated
Terraform
AWS VPC Networking
ECS
EC2
Auto Scaling
Application Load Balancer
RDS PostgreSQL
Infrastructure as Code
Cloud Architecture
DevOps Practices
Author

Yash Mayekar

Disclaimer

This project is built for educational and portfolio purposes and demonstrates production-style AWS infrastructure architecture using Terraform.
