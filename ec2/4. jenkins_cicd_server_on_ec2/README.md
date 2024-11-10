# 🎉 Jenkins CI/CD Server on EC2 with Backup and Monitoring 🎉

## 🚀 Project Overview
This project automates the deployment of a **Jenkins CI/CD Server** on an **EC2 instance** within AWS. It integrates essential features like **automated backups** and **CloudWatch monitoring** to ensure the continuous availability, reliability, and scalability of Jenkins in production environments.

### 🔑 Key Features:
- **Jenkins CI/CD Setup**: Deploys Jenkins on an EC2 instance with a pre-configured setup for seamless integration.
- **Elastic IP**: Assigns a static Elastic IP to the Jenkins server for reliable access.
- **Automated Backups**: Ensures daily snapshots of Jenkins data to prevent data loss.
- **CloudWatch Monitoring**: Tracks performance metrics and sends alerts when thresholds are breached.
- **Security Best Practices**: Uses IAM roles, security groups, and VPC for secure access and minimal risk exposure.

---

## 🛠️ Project Objectives

### 1️⃣ EC2 Instance Configuration
The **EC2 instance** forms the backbone of this setup. Using **Amazon Linux** or **Ubuntu** as the base image, Jenkins is installed automatically through a **user-data script** that runs on startup. 

- **Elastic IP (EIP)**: A static IP ensures that the Jenkins server is always accessible.
- **CloudWatch Monitoring**: Monitor resource utilization (CPU, memory, disk) to identify potential issues early.

### 2️⃣ EBS Volume and Backup
To ensure persistent storage for Jenkins, we attach an **EBS volume** to the EC2 instance for storing Jenkins data (jobs, configurations, logs).

- **Automated Daily Snapshots**: Using a **Lambda function**, we create daily snapshots of the EBS volume, ensuring we can recover from any data loss or corruption.
- **S3 Backups**: Snapshots are stored in **S3** for high durability and long-term retention.

### 3️⃣ IAM Roles and Policies
To ensure secure access, **IAM roles** are assigned to both the EC2 instance and Lambda function. These roles allow them to interact with **CloudWatch** for monitoring and **S3** for backups.

- **IAM Role**: Restrict the EC2 instance and Lambda to only the permissions they need to function.
- **Least Privilege Principle**: Security is enforced by granting minimal access to resources.

### 4️⃣ CloudWatch Alarms and Logging
CloudWatch is configured to monitor and alert on key performance metrics (e.g., CPU, disk usage).

- **CloudWatch Alarms**: Set thresholds for critical metrics and receive alerts when exceeded.
- **CloudWatch Logs**: Capture Jenkins logs for troubleshooting and long-term log retention.

---

## 🌟 Real-Time Project Scenario

### 📈 Scenario Overview
In a large enterprise with multiple development teams, Jenkins is central to automating **CI/CD pipelines** for microservices deployed on AWS. Previously running Jenkins on an **on-premise server**, the team decides to migrate to **AWS** to take advantage of scalability, reliability, and cloud-native features.

With the migration to AWS, **Jenkins** is deployed on an **EC2 instance** with full **backup and monitoring** capabilities. This ensures:
- **High availability**: Elastic IP for consistent access.
- **Reliable backups**: Automated EBS snapshots and S3 backups.
- **Proactive monitoring**: CloudWatch alerts for early detection of issues like resource exhaustion or degraded performance.

### 🧑‍💻 Workflow:
1. **Set up Jenkins on EC2**: 
   - A new EC2 instance is provisioned with **Jenkins** installed via a user-data script.
   - The **Elastic IP** ensures Jenkins is consistently accessible.
   
2. **Attach EBS Volume for Data**: 
   - Jenkins data is stored on an **EBS volume**, which is periodically backed up via **Lambda**-automated **EBS snapshots**.
   
3. **CloudWatch Monitoring & Alerts**: 
   - Resource metrics (CPU, memory, disk) are monitored using **CloudWatch**.
   - If any resource exceeds the defined threshold, an **SNS** alert is triggered for rapid response.
   
4. **Security**: 
   - **IAM roles** are configured to provide only the necessary permissions for EC2 and Lambda to interact with AWS resources.
   - Security Groups limit access to Jenkins to trusted IPs only.

---

## 🏗️ Architecture Diagram

```mermaid
graph TD
    A[EC2 Instance (Jenkins Server)] --> B[EBS Volume]
    B --> C[EBS Snapshot (Automated Backup)]
    A --> D[Elastic IP]
    A --> E[CloudWatch Monitoring]
    A --> F[CloudWatch Logs]
    F --> G[CloudWatch Alarms]
    G --> H[SNS Notifications]
    E --> I[Lambda (Snapshot Automation)]
    E --> J[S3 Backup Storage]
    D --> K[Public Access]
    I --> L[EBS Snapshot Permissions]
    K --> M[Jenkins Access]
```
## Terraform Resources
This project uses **Terraform** to provision the necessary AWS resources. Key resources include:
- `aws_instance`: Deploys the EC2 instance for Jenkins, providing the server infrastructure.
- `aws_ebs_volume` & `aws_ebs_snapshot`: Manages Jenkins data storage and creates automated backups.
- `aws_iam_role` & `aws_iam_policy`: Configures IAM roles and permissions for EC2 and Lambda.
- `aws_lambda_function` & `aws_cloudwatch_event_rule`: Automates the snapshot process with Lambda and schedules it with CloudWatch Events.
- `aws_cloudwatch_metric_alarm`: Creates alarms to monitor the performance of the EC2 instance and triggers notifications via SNS.

## Steps to Deploy

### Prerequisites
Before deploying this project, ensure that you have the following:
- **Terraform** installed.
- AWS **credentials** configured (via AWS CLI or environment variables).
- An AWS account with necessary permissions to create EC2, EBS, IAM, Lambda, CloudWatch, and SNS resources.

### Deployment Instructions
1. Clone this repository:
```bash
        git clone https://github.com/your-username/jenkins-ec2-backup-monitoring.git
        cd jenkins-ec2-backup-monitoring
```
2. Initialize Terraform:
```bash
    terraform init
```
3. Apply the Terraform configuration to provision resources:
```bash
    terraform apply
```
4. After deployment, you will see the public IP/DNS of the Jenkins server, EBS volume ID, and snapshot details in the Terraform output.
5. Access Jenkins via the public IP or DNS and start configuring your CI/CD pipelines.**

### Security Considerations
*** To maintain the security of your infrastructure:***

- IAM roles and policies should always follow the principle of least privilege. This means assigning only the necessary permissions to each service, which minimizes the risk of unauthorized access.
- Encryption should be enabled for both EBS volumes and S3 backup storage to protect sensitive data.
- Security Groups should be configured to restrict Jenkins access to trusted IP ranges, reducing the potential attack surface.
## Monitoring and Alerts
- CloudWatch Alarms will notify you if CPU, memory, or disk usage exceeds the set threshold, helping to prevent resource exhaustion or poor performance.
- SNS Notifications will be sent to your email or mobile number for quick action on any alerts.
### License
- This project is licensed under the MIT License - see the LICENSE file for details.

- Avinash Wagh
- LinkedIn: [www.linkedin.com/in/avinash-wagh101]
- [GitHub:](https://github.com/Tiger-a11y/terraform-practice/tree/main/ec2/4. jenkins_cicd_server_on_ec2)

*** Feel free to open issues or contribute to improve the project! ***