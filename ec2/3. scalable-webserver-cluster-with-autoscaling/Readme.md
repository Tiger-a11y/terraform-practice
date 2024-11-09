# High-Availability Web Application with Load Balancer and Auto Scaling

## Project Overview
This project creates a highly available, scalable web application infrastructure on AWS using **Elastic Load Balancer (ELB)**, **Auto Scaling Group (ASG)**, and **EC2 instances**. The combination of these components allows the infrastructure to automatically balance traffic loads and scale the application based on demand, ensuring high availability and optimal performance.

---

### Key Components

- **EC2 Instances**: Amazon Elastic Compute Cloud (EC2) instances are virtual servers that host applications. In this project, EC2 instances serve as the servers that host the web application.

- **Auto Scaling Group (ASG)**: An ASG is a service that automatically adjusts the number of EC2 instances in response to traffic demand. By scaling in or out, ASGs help ensure that applications run smoothly without under-provisioning or over-provisioning resources.

- **Elastic Load Balancer (ELB)**: ELB distributes incoming application or network traffic across multiple EC2 instances. It improves fault tolerance and high availability by sending requests only to healthy instances.

- **Elastic IP (EIP)**: An EIP is a static IPv4 address designed for dynamic cloud computing, allowing you to allocate and reassign the address to different EC2 instances or load balancers, ensuring stable access.

- **Security Group**: A security group acts as a virtual firewall that controls inbound and outbound traffic to resources. In this setup, security groups allow HTTP, HTTPS, and SSH traffic.

---

## Architecture

1. **Elastic Load Balancer (ELB)**: The ELB distributes incoming requests across multiple EC2 instances to ensure availability. It listens on standard HTTP (port 80) and HTTPS (port 443) ports, directing traffic to healthy instances in the ASG.

2. **Auto Scaling Group (ASG)**: The ASG dynamically adjusts the number of EC2 instances based on traffic patterns and demand. It’s configured with scaling policies to automatically increase instances during peak times and decrease them during off-peak hours.

3. **Elastic IP**: The EIP provides a static IP address linked to the load balancer, allowing users to consistently access the application without IP changes.

4. **Security Group**: A security group is defined to allow necessary inbound and outbound traffic, specifically allowing HTTP (80), HTTPS (443), and SSH (22) access.

---

## Implementation Details (Terraform)

This infrastructure is provisioned using **Terraform** to automate and standardize the deployment process.

### 1. Define Security Group
   - Define a security group that opens ports 80 (HTTP), 443 (HTTPS), and 22 (SSH) to ensure web and SSH access.
   - Attach this security group to the EC2 instances and the ELB.

### 2. Create Launch Template
   - Define an EC2 launch template that specifies the AMI, instance type, key pair, and other instance properties.
   - Use a **user data script** to install and configure a web server (such as Apache or NGINX) on each instance upon initialization.

### 3. Set up Elastic Load Balancer
   - Create the ELB with listeners on ports 80 and 443.
   - Set up health checks to monitor instance health and only route traffic to healthy instances.
   - Attach the security group to allow HTTP/HTTPS access.

### 4. Configure Auto Scaling Group
   - Link the ASG to the ELB so that new instances are automatically registered.
   - Set a **minimum and maximum number of instances** for scaling.
   - Define scaling policies based on CPU utilization or other metrics to automatically adjust instance count.

### 5. Outputs
   - Provide the **public DNS** of the load balancer as an output for easy access to the application.

---

## Prerequisites

- **AWS Account**: An active AWS account with IAM permissions to manage EC2, ELB, and ASG resources.
- **Terraform Installed**: Install Terraform on your local machine or CI/CD pipeline to apply this infrastructure.

---

## Usage Instructions

1. **Clone this repository**:
   ```bash
   git clone <repository_url>
   cd high-availability-web-app

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

- **Configuring Auto Scaling and Load Balancing**: Learn to set up an Auto Scaling Group and Elastic Load Balancer to ensure high availability.
- **Terraform Module Management**: Develop modular and reusable configurations with Terraform for flexible infrastructure management.
- **Setting Scaling Policies**: Configure scaling policies to adjust resources based on demand, reducing manual management.

---

### Future Enhancements

- **Logging and Monitoring**: Integrate AWS CloudWatch to log ELB and ASG activities and set up alerts for proactive issue detection.
- **SSL Configuration**: Add SSL/TLS certificates for secure HTTPS traffic on the load balancer.
- **Database Integration**: Expand this project by adding an RDS or DynamoDB instance to manage persistent application data.

This project demonstrates building a reliable and scalable web application infrastructure with Terraform. The setup can handle traffic variations, ensuring high uptime and optimal performance.