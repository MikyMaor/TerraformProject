# 🚀 Terraform AWS Infrastructure Project

## Final exam — `final-exam/builder`

| Component | Status |
|-----------|--------|
| `final-exam/builder/` EC2 in VPC `vpc-044604d0bfb707142` | ✅ Done |
| Git Flow branches (`main`, `dev`, feature) | ✅ Done |
| `terraform apply` on AWS | ❌ Run manually |

---

This repository demonstrates building AWS infrastructure using **Terraform**, progressing from a basic setup to a fully modular, auto-scaled architecture.
The project is divided into **foundational tasks (1–2)** and **advanced infrastructure tasks (3–5)**.

---

## 📁 Project Structure

```
Terraform_Exam/
├── Tasks 1 & 2/                 # Basic VPC & EC2 setup
├── Tasks 3 & 4/
│   └── Modules/
│       ├── Custom_vpc_ec2/   # VPC, subnets & base EC2
│       ├── LB_TG_AS/         # Load Balancer & Auto Scaling
│       └── Deployments/      # Full environment orchestration
└── Answers.txt               # Terraform exam A
```

---

## 🧱 Tasks 1 & 2 – Basic Infrastructure

Terraform configuration that provisions:

* 🌐 VPC with:

  * Public subnet: `10.0.1.0/24`
  * Private subnet: `10.0.2.0/24`
* 🌍 Internet Gateway with public routing
* 🔐 Security Group (SSH 22, HTTP 80)
* 🖥️ EC2 instance (`t3.micro`) with public IP

📍 Run from the `Tasks 1 & 2` directory.

---

## 🏗️ Tasks 3 & 4 – Modular & Scalable Setup

Advanced, production-style infrastructure using Terraform modules.

---

### 🔹 Module: Custom_vpc_ec2

* Creates VPC and multiple subnets (AZ-based, configurable)
* Generates SSH key pair (`id_rsa_generated.pem`)
* Launches EC2 with **Nginx** and **stress-ng**
* Health endpoint returns `Healthy`
* Outputs VPC, subnet, SG, EC2 IDs and key name

---

### 🔹 Module: LB_TG_AS

* Public Application Load Balancer
* Target Group with HTTP health checks
* Custom AMI built from base EC2
* Launch Template with delayed CPU stress test
* Auto Scaling Group (1–3 instances)
* CPU target tracking at **50%**

📈 Behavior:

* CPU load starts after ~3 minutes
* Scales out when CPU > 50%
* Scales in when CPU < 50%
* Minimum of 1 running instance

---

### 🔹 Module: Deployments

* Connects all modules together
* Creates VPC, EC2, ALB, AMI and ASG
* Applies CPU-based scaling policies

---

## ▶️ Usage

### Prerequisites

* Terraform `>= 1.0`
* AWS CLI configured
* Sufficient AWS permissions

### Deploy

**Tasks 1 & 2**

```bash
cd Tasks\ 1\ \&\ 2
terraform init
terraform apply
```

**Tasks 3 & 4**

```bash
cd Tasks\ 3\ \&\ 4 /Modules/Deployments
terraform init
terraform apply
```

---


### 🗺️ Architecture Diagram

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

    Auto Scaling Group (1–3 instances)
    CPU-based scaling at 50%


## 🔍 Testing Auto Scaling

* Access the Load Balancer DNS from Terraform outputs
* Expected response: ✅ `Healthy`

Monitor via AWS Console:

* CloudWatch – CPU metrics
* EC2 – instance count
* Target Group – health status

⏱️ Timeline:

* ~3 min: CPU load starts
* ~5–10 min: scales up to 3 instances
* ~15–20 min: scales back to 1 instance

---

## 🧠 Key Concepts

* Modular Terraform design
* Multi-AZ deployments
* Auto Scaling with target tracking
* Custom AMI creation
* Load balancing & health checks
* Infrastructure as Code best practices

---

## 🧹 Cleanup

```bash
terraform destroy
```

⚠️ Note: In some cases, AMIs may require manual deregistration.

---

## 📚 Additional Notes

`EXAM_Answers.docx` contains Terraform exam-related questions and answers covering:

* Core concepts
* State management
* Modules
* AWS integrations
* Troubleshooting
