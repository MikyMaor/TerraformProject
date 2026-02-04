# Terraform AWS Infrastructure Exam

This repository demonstrates Terraform configurations for deploying AWS cloud infrastructure. The project is divided into foundational setup (Tasks 1 & 2) and advanced modular architecture (Tasks 3, 4 & 5).

## Project Structure

Terraform_Exam/
├── Tasks1_2/              # Foundational VPC and EC2 configuration
├── Tasks3_4_5/            # Advanced modular setup
│   └── Modules/
│       ├── Custom_vpc_ec2/    # VPC, networking, and compute resources
│       ├── LB_TG_AS/          # Load balancing and auto-scaling
│       └── Deployments/       # Main deployment orchestration
└── Answers.txt            # Terraform knowledge base and exam responses

## Tasks 1 & 2: Foundational Infrastructure

Basic Terraform configuration that provisions:

- Virtual Private Cloud with public subnet (10.0.1.0/24) and private subnet (10.0.2.0/24)
- Internet Gateway with routing configured for the public subnet
- Security Group permitting SSH access (port 22) and HTTP traffic (port 80)
- EC2 Instance of type t3.micro deployed in the public subnet with public IP assignment

Run from the Tasks1_2 directory

## Tasks 3, 4 & 5: Advanced Modular Architecture

Enterprise-grade infrastructure featuring auto-scaling web servers managed by a load balancer.

### Module 1: Custom_vpc_ec2

Establishes VPC infrastructure with a pre-configured EC2 instance.

Main Capabilities:

- Dynamic subnet provisioning across multiple availability zones (configurable quantity)
- Automatic SSH key pair generation (stored as id_rsa_generated.pem)
- EC2 instance pre-installed with Nginx web server and stress-ng testing utility
- Default health check page displaying "Healthy" status
- Exports: VPC identifier, subnet identifiers, security group identifier, instance identifier, key pair name

### Module 2: LB_TG_AS

Auto-scaling infrastructure with intelligent load distribution.

Primary Components:

- Application Load Balancer - Publicly accessible, manages traffic distribution
- Target Group - Monitors instance health on port 80 using root path
- Custom AMI - Generated from the base EC2 instance (pre-configured with Nginx)
- Launch Template - Executes CPU stress testing after a 3-minute initialization delay
- Auto Scaling Group - Maintains between 1 and 3 instances, starting with 1
- Scaling Policy - Implements target tracking based on 50% CPU threshold

Auto-Scaling Mechanism:

- Newly launched instances initiate CPU load using stress-ng for 10 minutes
- When average CPU exceeds 50%: Additional instances are launched
- When average CPU falls below 50%: Excess instances are terminated
- Always maintains at least 1 instance

### Module 3: Deployments

Coordinates the complete deployment by integrating both modules.

Deployment Sequence:

- Establishes VPC with 3 subnets, security group configuration, and initial EC2 instance
- Transfers VPC resources to the LB_TG_AS module
- Provisions load balancer, creates AMI, and configures auto-scaling group
- Implements CPU-based scaling policies

## Usage

Prerequisites:
- Terraform version 1.0 or higher
- AWS CLI configured with valid credentials
- Sufficient AWS permissions for resource creation

Deployment Instructions:

Tasks 1 & 2:
Navigate to Tasks1_2 directory
Initialize Terraform
Review the planned changes
Apply the configuration

Tasks 3, 4 & 5:
Navigate to Tasks3_4_5/Modules/Deployments directory
Initialize Terraform
Review the planned changes
Apply the configuration

## Testing Auto-Scaling

Retrieve the load balancer DNS name from Terraform outputs

Test the application endpoint:
Access the load balancer URL in your browser or using curl
Expected response: Healthy status message

Monitor the infrastructure using AWS Console:
- CloudWatch: View CPU utilization metrics
- EC2 Dashboard: Observe new instances being launched
- Target Group: Check instance registration status

Expected Behavior Timeline:

Approximately 3 minutes: CPU load generation begins
Around 5-10 minutes: Instance count scales up to 3
Approximately 13 minutes: CPU load generation stops
Around 15-20 minutes: Instance count scales down to 1

## Architecture Overview

                    Internet
                       │
                 ┌─────▼─────┐
                 │    ALB    │
                 │ (Port 80) │
                 └─────┬─────┘
                       │
        ┌──────────────┼──────────────┐
        │              │              │
    ┌───▼───┐      ┌───▼───┐      ┌───▼───┐
    │ AZ-1  │      │ AZ-2  │      │ AZ-3  │
    │Subnet │      │Subnet │      │Subnet │
    └───┬───┘      └───┬───┘      └───┬───┘
        │              │              │
    ┌───▼───┐      ┌───▼───┐      ┌───▼───┐
    │ EC2   │      │ EC2   │      │ EC2   │
    │Nginx  │      │Nginx  │      │Nginx  │
    └───────┘      └───────┘      └───────┘
    
    Auto Scaling Group (1-3 instances)
    Triggers scaling at 50% CPU utilization

## Key Concepts Demonstrated

✅ Modular Terraform design patterns
✅ Dynamic resource provisioning using count parameter
✅ Multi-availability zone deployment for high availability
✅ Auto-scaling with target tracking policies
✅ Custom AMI generation from running instances
✅ Remote provisioning using SSH
✅ Load balancing with automated health checks
✅ Infrastructure as Code industry best practices

## Resource Cleanup

Tasks 1 & 2:
Navigate to Tasks1_2 directory
Execute Terraform destroy command

Tasks 3, 4 & 5:
Navigate to Tasks3_4_5/Modules/Deployments directory
Execute Terraform destroy command

Important Note: AMI resources may require manual deregistration if automated cleanup fails.

## Additional Resources

The Answers.txt file contains comprehensive Terraform exam questions and answers covering:
- Terraform fundamentals and core concepts
- State management strategies
- Module development and usage
- AWS service configurations
- Debugging and troubleshooting techniques

## Learning Outcomes

This project provides hands-on experience with:
- VPC networking and subnet design
- EC2 instance provisioning and configuration
- Terraform module architecture
- Auto-scaling group implementation
- Load balancer configuration and management
- Infrastructure as Code best practices for AWS cloud environments
