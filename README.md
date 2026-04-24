# Final Project — DevOps Infrastructure on AWS

## Overview

This project demonstrates a complete DevOps pipeline for deploying a Django application on AWS using modern infrastructure and automation tools. The infrastructure is provisioned with Terraform, containerization is handled via Docker, and deployment is managed through Kubernetes (EKS), Jenkins (CI), and Argo CD (CD with GitOps approach).

---

## Technology Stack

- **Cloud Provider:** AWS (EKS, RDS, ECR, S3, DynamoDB)
- **Infrastructure as Code:** Terraform
- **Containerization:** Docker
- **Orchestration:** Kubernetes (EKS)
- **CI/CD:**
  - Jenkins (CI)
  - Argo CD (CD / GitOps)
- **Monitoring:**
  - Prometheus
  - Grafana
- **Package Manager:** Helm
- **Application:** Django (Python)

---

## Project Structure

```
.
├── Django/                    # Application source code
│   ├── Dockerfile
│   ├── Jenkinsfile
│   ├── docker-compose.yaml
│   └── app/
│
├── charts/
│   └── django-app/           # Helm chart for Django app
│
├── modules/                  # Terraform modules
│   ├── vpc/
│   ├── eks/
│   ├── ecr/
│   ├── rds/
│   ├── jenkins/
│   ├── argo_cd/
│   ├── monitoring/
│   └── s3-backend/
│
├── screenshots/              # Screenshots (to be added)
│
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── backend.tf
```

---

## Deployment Stages

### 1. Environment Preparation

- Initialize Terraform
- Verify variables and configuration

```bash
terraform init -backend=false
terraform validate
```

---

### 2. Backend Setup (S3 + DynamoDB)

Deploy backend resources for Terraform state:

```bash
terraform apply
```

After that, enable backend:

```bash
terraform init
```

---

### 3. Infrastructure Deployment

Deploy full infrastructure:

```bash
terraform apply
```

This will create:

- VPC and networking
- EKS cluster
- ECR repository
- RDS PostgreSQL database
- Jenkins (CI)
- Argo CD (CD)
- Monitoring stack (Prometheus + Grafana)

---

### 4. Kubernetes Resources Verification

Check deployed resources:

```bash
kubectl get all -n jenkins
kubectl get all -n argocd
kubectl get all -n monitoring
```

---

### 5. Access Verification

#### Jenkins

```bash
kubectl port-forward svc/jenkins 8080:8080 -n jenkins
```

Open: http://localhost:8080

---

#### Argo CD

```bash
kubectl port-forward svc/argocd-server 8081:443 -n argocd
```

Open: https://localhost:8081

---

### 6. Monitoring and Metrics

#### Grafana

```bash
kubectl port-forward svc/monitoring-grafana 3000:80 -n monitoring
```

Open: http://localhost:3000

- Verify dashboards
- Check metrics from Prometheus

---

## CI/CD Workflow

1. Developer pushes code to GitHub (`final-project` branch)
2. Jenkins:
   - Builds Docker image
   - Pushes image to ECR
   - Updates Helm values (image tag)
3. Argo CD:
   - Detects changes in repository
   - Automatically deploys updated application

---

## Module Verification

### VPC

- Check subnets, routing, NAT, IGW

### EKS

```bash
kubectl get nodes
```

---

### ECR

- Verify repository and images in AWS Console

---

### RDS

```bash
terraform output rds_postgres_endpoint
```

---

### Jenkins

- Pipeline runs successfully
- Image pushed to ECR

---

### Argo CD

- Application status: Synced / Healthy

---

### Monitoring

- Prometheus targets are up
- Grafana dashboards display metrics

---

## Screenshots

Screenshots are located in:

```
/screenshots
```

Naming convention:

- `p1_...` — Environment setup
- `p2_...` — Infrastructure deployment
- `p3_...` — Jenkins
- `p4_...` — Argo CD
- `p5_...` — Monitoring

---

## Conclusion

This project demonstrates a full DevOps lifecycle:

- Infrastructure provisioning with Terraform
- Containerization with Docker
- CI/CD pipeline with Jenkins and Argo CD
- Kubernetes deployment on AWS EKS
- Monitoring with Prometheus and Grafana

The solution is scalable, automated, and follows modern DevOps best practices.
