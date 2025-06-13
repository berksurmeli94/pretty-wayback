# pretty-wayback-infra

## Overview

This directory contains the infrastructure-as-code setup for the **pretty-wayback** project. It uses Terraform to provision and manage cloud resources across different environments (e.g., development and production).

## Structure

- **`main.tf`**: Entry point for defining resources and modules.
- **`variables.tf`**: Input variables for configuring the infrastructure.
- **`outputs.tf`**: Outputs for sharing data between modules or environments.
- **`envs/`**: Environment-specific configurations (e.g., `dev`, `prod`).
- **`modules/`**: Reusable Terraform modules for services like PostgreSQL, Elasticsearch, Redis, etc.
- **`.github/workflows/deploy.yml`**: CI/CD pipeline for deploying infrastructure.

## Prerequisites

- [Terraform](https://www.terraform.io/)
- [AWS CLI](https://aws.amazon.com/cli/)
- Properly configured AWS credentials.

## Setup

### Clone the Repository

```sh
git clone https://github.com/berksurmeli94/pretty-wayback.git
cd pretty-wayback/pretty-wayback-infra