# 🏗️ AWS Infrastructure Automation — Terraform

> Production-style AWS cloud infrastructure provisioned entirely with Terraform IaC, designed to host containerized applications with high availability, private networking, and automated scaling.

---

## 📐 Architecture Overview

```
                        ┌─────────────────────────────┐
                        │          Internet            │
                        └──────────────┬──────────────┘
                                       ↓
                        ┌─────────────────────────────┐
                        │   Application Load Balancer  │
                        │       (Public Subnets)       │
                        └──────────────┬──────────────┘
                                       ↓
                        ┌─────────────────────────────┐
                        │         Target Group         │
                        └──────────────┬──────────────┘
                                       ↓
                        ┌─────────────────────────────┐
                        │   ECS Services / ECS Tasks   │
                        │       (Private Subnets)      │
                        └──────────────┬──────────────┘
                                       ↓
                        ┌─────────────────────────────┐
                        │      PostgreSQL RDS           │
                        │       (Private Subnets)      │
                        └─────────────────────────────┘
```

---

## ☁️ AWS Services Used

| Service | Purpose |
|---|---|
| **VPC** | Private cloud network |
| **ECS** | Container orchestration |
| **EC2** | ECS worker nodes |
| **ALB** | Traffic distribution |
| **Auto Scaling Group** | Automatic EC2 scaling |
| **RDS PostgreSQL** | Managed relational database |
| **IAM** | Access management |
| **CloudWatch** | Logging and monitoring |
| **NAT Gateway** | Internet access for private subnets |

---

## 📁 Project Structure

```
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
└── README.md
```

---

## ✨ Features

### 🌐 Networking
- Custom VPC with CIDR block `10.0.0.0/16`
- Public and private subnet architecture across multiple AZs
- Internet Gateway for public internet access
- NAT Gateway for secure outbound internet from private subnets

### 🔒 Security
- Security Groups with least-privilege access
- ECS instances accessible **only** through the ALB
- PostgreSQL accessible **only** from ECS containers
- Sensitive variables managed via Terraform variables

### 🐳 ECS Infrastructure
- ECS Cluster using EC2 launch type
- Task Definitions, Services, and Launch Templates
- Auto Scaling Groups for dynamic capacity management

### ⚖️ Load Balancing
- Internet-facing Application Load Balancer
- Target Groups for ECS containers
- Listener rules for traffic forwarding

### 🗄️ Database
- PostgreSQL RDS deployed in private subnets
- Isolated networking — not publicly accessible

### 📊 Monitoring
- CloudWatch Log Groups for ECS containers
- Infrastructure-level logging support

---

## ✅ Prerequisites

Before running this project, ensure you have:

- An **AWS Account**
- **Terraform >= 1.5** installed
- **AWS CLI** configured
- Sufficient **IAM permissions** to provision AWS resources
- **Git** installed

### Configure AWS CLI

```bash
aws configure
```

Provide your:
- AWS Access Key ID
- AWS Secret Access Key
- Default Region
- Output Format

---

## 🚀 Terraform Workflow

```bash
# 1. Initialize Terraform
terraform init

# 2. Validate configuration
terraform validate

# 3. Preview infrastructure changes
terraform plan

# 4. Deploy infrastructure
terraform apply

# 5. Destroy infrastructure (when done)
terraform destroy
```

---

## 🔐 Security Best Practices

> ⚠️ **Important:** This project excludes sensitive files via `.gitignore`

The following are **never committed** to version control:

```
*.tfvars
*.tfstate
*.tfstate.backup
.terraform/
```

---

## 🔮 Future Improvements

- [ ] HTTPS support using ACM certificates
- [ ] Route53 DNS integration
- [ ] Migrate to ECS Fargate
- [ ] Refactor into reusable Terraform modules
- [ ] Remote state backend (S3 + DynamoDB)
- [ ] CI/CD pipeline integration
- [ ] CloudWatch alarms and alerting
- [ ] Multi-AZ NAT Gateway deployment
- [ ] AWS Secrets Manager integration

---

## 🛠️ Skills Demonstrated

`Terraform` `AWS VPC Networking` `ECS` `EC2` `Auto Scaling` `Application Load Balancer` `RDS PostgreSQL` `Infrastructure as Code` `Cloud Architecture` `DevOps`

---

## 👤 Author

**Yash Mayekar**

---

## ⚠️ Disclaimer

> This project is built for **educational and portfolio purposes** and demonstrates production-style AWS infrastructure architecture using Terraform.
