# Scalable Web Server Cluster with Application Load Balancer and Auto Scaling

![Architecture of a scalable web server](./images/Architecture%20of%20a%20scalable%20web%20server.webp)  

## Project Overview

This project sets up a highly available and scalable web server infrastructure using AWS. It provisions a cluster of EC2 instances running a web application, with **Auto Scaling** to manage dynamic traffic and an **Application Load Balancer (ALB)** to distribute requests across instances. Logging and monitoring are enabled for improved observability.

---

### Project Objectives

1. **Application Load Balancer (ALB)**:
   - Create an ALB that listens on HTTP (port 80) and HTTPS (port 443).
   - Configure the ALB to distribute incoming requests across instances in multiple **Availability Zones (AZs)**, enhancing fault tolerance.

2. **Auto Scaling Group (ASG)**:
   - Set up an ASG with a minimum of 2 instances, scaling up to 5 based on CPU utilization.
   - Define scaling policies to automatically increase or decrease the number of instances based on CPU load, ensuring cost-effective and resilient scaling.

3. **EC2 Instances**:
   - Use Amazon Linux AMI for web servers.
   - Install and configure **Apache** (or **NGINX**) to serve a basic HTML application, using user data scripts for automation.
   - Enable the **Instance Metadata Service (IMDSv2)** to enhance security by enforcing session-based metadata access.

4. **Security**:
   - Define a **Security Group** allowing HTTP (80), HTTPS (443), and SSH (22) access, restricted to specific IP addresses.
   - Assign an **IAM role** to the instances, permitting ALB access logging to an S3 bucket for better tracking of traffic and issues.

5. **Outputs**:
   - Provide essential outputs:
     - **ALB DNS Name** for accessing the application.
     - **Instance IDs** of the EC2 instances within the ASG.
     - **S3 Bucket Name** where ALB access logs are stored.

---

### Architecture Diagram

![Architecture Diagram](./images/flowchart%201.drawio.svg)  
*Diagram: Infrastructure layout of the scalable web server cluster.*

---

## Detailed Implementation using Terraform

### Key Terraform Resources

1. **aws_security_group**
   - Configures access permissions, allowing HTTP (80), HTTPS (443), and SSH (22) connections, with IP-based restrictions.

2. **aws_alb** and **aws_alb_listener**
   - Provisions an ALB with listeners on ports 80 and 443.
   - Configures the ALB to distribute traffic across multiple AZs, improving fault tolerance.

3. **aws_autoscaling_group**
   - Sets up an ASG to maintain a minimum of 2 instances and automatically scale to a maximum of 5.
   - Defines scaling policies based on CPU usage, allowing automatic scaling to handle changing traffic.

4. **aws_launch_template**
   - Specifies EC2 instance configurations, including the AMI, instance type, and user data scripts for web server setup.

5. **aws_iam_role** and **aws_iam_policy**
   - Assigns an IAM role with permissions to enable ALB logging to an S3 bucket.

6. **aws_s3_bucket**
   - Creates an S3 bucket to store ALB access logs for monitoring and troubleshooting.

---

## Step-by-Step Deployment Instructions

1. **Clone the Repository**:
   ```bash
   git clone <repository_url>
   cd scalable-web-server-cluster

### Key Steps

1. **Set up Terraform**:

   - **Initialize the Terraform configuration**:
     ```bash
     terraform init
     ```

   - **Plan the infrastructure**:
     Review the planned changes before applying them.
     ```bash
     terraform plan
     ```

   - **Apply the infrastructure**:
     Provision resources on AWS.
     ```bash
     terraform apply
     ```

2. **Access the Application**:

   Once the infrastructure is deployed, you can access the application using the public DNS provided in the Terraform output.

3. **Monitoring**:

   - Use the AWS Console to monitor EC2 instances and Auto Scaling activities.
   - Review CloudWatch metrics for insights into scaling activities and ELB health checks.

---

### Skills Gained

- **Load Balancing and Scaling:** Set up and manage load-balanced, auto-scaled web server clusters.
- **Terraform Resource Management:** Define and organize AWS resources with Terraform, ensuring modular, reusable infrastructure code.
- **Security Best Practices:** Enforce secure access controls and metadata management using IAM roles and IMDSv2.
- **Logging and Monitoring:** Enable logging and monitor access logs for application performance insights.

---

### Future Enhancements

- **Advanced Monitoring:** Integrate with AWS CloudWatch Alarms to alert on high CPU or request thresholds, ensuring proactive scaling.
- **SSL/TLS Certificates:** Configure HTTPS with an SSL/TLS certificate for secure traffic encryption.
- **Database Integration:** Add an RDS or DynamoDB instance to store persistent data, allowing the web servers to handle more complex application requirements.

*** Feel free to open issues or contribute to improve the project! ***

- Avinash Wagh
- LinkedIn: [www.linkedin.com/in/avinash-wagh101]
- [GitHub:](https://github.com/Tiger-a11y/terraform-practice/tree/main/ec2/3. scalable-webserver-cluster-with-autoscaling)