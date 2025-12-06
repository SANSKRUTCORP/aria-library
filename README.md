# Aria University Digital Library

This repository contains the infrastructure code and deployment scripts for the Aria University Digital Library, built on DSpace 8 and AWS.

## Architecture

- **Software**: DSpace 8 (Java 17, Spring Boot), Angular Frontend, Apache Solr.
- **Infrastructure**: AWS (EC2, RDS PostgreSQL, S3, ALB) managed via Terraform.

## Directory Structure

- `terraform/`: Terraform configuration for AWS infrastructure.
- `scripts/`: Shell scripts for server provisioning and DSpace installation.

## Deployment Guide

### Prerequisites
- Terraform v1.2.0+
- AWS CLI configured
- Git

### Steps

1.  **Provision Infrastructure**:
    ```bash
    cd terraform
    terraform init
    terraform apply
    ```

2.  **Access Application**:
    - DSpace Backend: `http://<EC2-IP>:8080/server`
    - DSpace Frontend: `http://<EC2-IP>:4000`

## CI/CD (GitHub Actions)

This repository includes a GitHub Actions workflow `.github/workflows/terraform.yml` that automatically validates and plans Terraform changes.

### Required Secrets
To enable the CI/CD pipeline, go to **Settings > Secrets and variables > Actions** in your GitHub repository and add the following repository secrets:

- `AWS_ACCESS_KEY_ID`: Your AWS Access Key ID.
- `AWS_SECRET_ACCESS_KEY`: Your AWS Secret Access Key.

