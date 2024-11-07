# 🌐 Terraform AWS Practice Project

Welcome to the **Terraform AWS Practice Project**! This repository is a structured, hands-on practice resource for using **Terraform** to create and manage AWS infrastructure. The setup follows a progressive approach: you’ll start by working with individual resources and then move on to multi-resource environments, modularizing components, and experimenting with advanced Terraform capabilities.

---

## 📌 Project Overview

This project is built for anyone looking to:
- **Gain practical Terraform skills**: Deploy and manage AWS resources using Terraform.
- **Understand best practices**: Organize Terraform code into reusable and scalable modules.
- **Prepare for real-world DevOps scenarios**: Combine multiple resources, handle dependencies, and use Terraform for complex infrastructure setups.

The repository contains folders for each major AWS resource (EC2, S3, VPC, RDS) and combined resources, allowing incremental practice.

---

## 🗂 Repository Structure

This repository is organized into folders for individual AWS resources and multi-resource setups. Each folder includes configuration files and instructions for deploying and testing the specific resource(s) with Terraform.

```plaintext
terraform-aws-practice/
├── ec2/
├── s3/
├── vpc/
├── rds/
├── multi-resource-practice/
│   ├── vpc-ec2/
│   └── vpc-ec2-rds/
└── modules/


## 📂 Folder Descriptions

### `ec2/` - EC2 Instance Setup
- **Purpose**: Provides configurations for creating an **EC2 instance**.
- **Files**:
  - **main.tf**: Defines EC2 instance configurations, such as AMI, instance type, and security groups.
  - **variables.tf**: Allows customization with input variables for settings like instance type.
  - **outputs.tf**: Outputs key instance details, such as instance ID and IP address, for reference.
  - **README.md**: Describes EC2 configurations and provides instructions for launching and managing the instance.

### `s3/` - S3 Bucket Setup
- **Purpose**: Contains configurations for creating and managing an **S3 bucket**.
- **Files**:
  - **main.tf**: Configures an S3 bucket with options for versioning, encryption, and lifecycle policies.
  - **variables.tf**: Input variables for bucket customization.
  - **outputs.tf**: Outputs details about the bucket, such as its URL.
  - **README.md**: Details S3 configurations and usage notes.

### `vpc/` - Virtual Private Cloud (VPC) Setup
- **Purpose**: Configures a **VPC** with essential networking components.
- **Files**:
  - **main.tf**: Defines a VPC with subnets, route tables, and an internet gateway.
  - **variables.tf**: Allows input for VPC CIDR blocks, subnets, and other networking components.
  - **outputs.tf**: Outputs important VPC details, such as subnet and VPC IDs.
  - **README.md**: Notes on setting up VPCs, subnets, and associated networking configurations.

### `rds/` - RDS (Relational Database Service) Setup
- **Purpose**: Sets up an **RDS instance** for relational database usage.
- **Files**:
  - **main.tf**: Configures an RDS instance with database engine, storage, and networking options.
  - **variables.tf**: Allows customization of database parameters, such as instance type and storage size.
  - **outputs.tf**: Outputs database endpoint and instance details.
  - **README.md**: Instructions for setting up and connecting to RDS, with connectivity and security considerations.

### `multi-resource-practice/` - Combined Resource Setups
This folder contains setups for practicing combined resources. It includes subfolders for progressively more complex configurations:
- **`vpc-ec2/`**: Configures a VPC and an EC2 instance within it, allowing for network and instance practice.
- **`vpc-ec2-rds/`**: Sets up a VPC, an EC2 instance, and an RDS instance, demonstrating secure connections between resources.

Each subfolder has:
  - **main.tf**: Defines resources and dependencies.
  - **variables.tf**: Allows input for configuration settings.
  - **outputs.tf**: Provides cross-referenced outputs from each setup for easy reference.

### `modules/` - Reusable Modules
- **Purpose**: Contains reusable **Terraform modules** for commonly used resources (e.g., EC2, VPC). This promotes reusability and scalability for larger projects.
- **Structure**:
  - Each module includes **main.tf**, **variables.tf**, and **outputs.tf**.
  - **README.md**: Documentation on module usage and parameters.

## 🚀 Getting Started

### **Prerequisites**

Before you begin, make sure you have the following set up:

- **Terraform**: [Install Terraform](https://www.terraform.io/downloads).
- **AWS CLI**: [Install and configure the AWS CLI](https://aws.amazon.com/cli/).
- **IAM User**: Ensure you have an IAM user with sufficient permissions to create and manage AWS resources.

### **Basic Terraform Commands**

To interact with Terraform, use the following commands:

1. **Initialize the Directory**:  
   Run this command to initialize the working directory and download required providers:
   ```bash
   terraform init

2. **Preview Changes (Plan):
   Preview the infrastructure changes that Terraform will make:
   ```bash
   terraform plan

3. Apply Changes:
   Apply the infrastructure changes to your AWS account:
    ```bash
    terraform apply

4. Destroy Resources:
    Destroy the resources created by Terraform:
    ```bash
    terraform destroy

### *** Usage Notes : ***
    Test each folder individually: Navigate to each folder and run terraform apply to test configurations.
    Modify configurations: Use the variables.tf or .tfvars files to tweak parameters and see how changes impact resources.
    Document your results: Keep track of your learning and document insights or issues in the README files provided in each folder.

### 📅 Project Roadmap
    As you progress, this repository can be expanded with the following steps:

    Single-Resource Practice:
    Start by working with individual resources like EC2, S3, VPC, and RDS.

    Multi-Resource Setups:
    Combine multiple resources in the multi-resource-practice/ folder to create more complex scenarios.

    Modularization:
    Build reusable modules in the modules/ folder for frequently used resources and configurations.

    Advanced Concepts:
    Explore advanced Terraform concepts like remote state, workspaces, and CI/CD for automated infrastructure deployments.

### 🤝 Contributing
    We encourage contributions! Please feel free to:

### Submit pull requests.
    Open issues for suggestions, bug reports, or feedback.

### 📄 License
    This project is licensed under the MIT License. For more details, see the LICENSE file.