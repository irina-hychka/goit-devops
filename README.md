# Homework for the topic "IaC (Terraform)"

## Project overview

This project demonstrates infrastructure provisioning in AWS using Terraform.  
It includes setting up a remote backend, networking infrastructure (VPC), and a container registry (ECR).

---

## Project structure

```
lesson-5/
│
├── main.tf
├── backend.tf
├── outputs.tf
│
├── modules/
│ │
│ ├── s3-backend/
│ │ ├── s3.tf
│ │ ├── dynamodb.tf
│ │ ├── variables.tf
│ │ └── outputs.tf
│ │
│ ├── vpc/
│ │ ├── vpc.tf
│ │ ├── routes.tf
│ │ ├── variables.tf
│ │ └── outputs.tf
│ │
│ └── ecr/
│ ├── ecr.tf
│ ├── variables.tf
│ └── outputs.tf
│
└── README.md
```

## AWS preparation

Before running Terraform:

1. Create an AWS account
2. Create an IAM user with programmatic access
3. Attach `AdministratorAccess` policy (for learning purposes)
4. Configure AWS CLI:

```bash
aws configure
```
Provide:

* Access Key ID
* Secret Access Key
* Region: us-west-2
* Output format: json

## Terraform commands

Initialize Terraform:

```
terraform init
```

Check configuration:

```
terraform validate
```

Preview changes:

```
terraform plan
```

Apply infrastructure:

```
terraform apply
```

Destroy infrastructure:

```
terraform destroy
```

## Modules description

### s3-backend

This module creates:
- S3 bucket for storing Terraform state
- DynamoDB table for state locking

Features:
- Versioning enabled
- Server-side encryption enabled
- Public access blocked

---

### vpc

This module creates networking infrastructure:

- VPC with custom CIDR block
- 3 public subnets
- 3 private subnets
- Internet Gateway for public subnets
- Single NAT Gateway for private subnets
- Route tables and associations

---

### ecr

This module creates:

- ECR repository
- Image scanning on push
- Lifecycle policy for image cleanup
- Repository access policy

---

## Notes

- Terraform state is stored remotely in S3
- DynamoDB is used for state locking
- Infrastructure is deployed in `us-west-2` region