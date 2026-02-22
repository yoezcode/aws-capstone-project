# AWS WordPress Infrastructure with Terraform

## Overview

This project provisions a highly available WordPress environment on AWS using Terraform.
The architecture evolves across three levels, starting from a single EC2 instance and progressing to a production-like multi-tier design with private compute, managed database, autoscaling, and load balancing.

The goal of the project is to learn cloud architecture fundamentals, networking, infrastructure as code, and operational patterns.

---

## Tech Stack

* Terraform
* AWS (VPC, EC2, RDS, ALB, ASG, NAT, Bastion)
* WordPress
* MySQL (MariaDB → RDS MySQL)

---

## Level 1 — Default Project

### Objective

Deploy a single WordPress instance with a local MySQL database inside a custom VPC.

### Implemented Components

* Custom VPC
* 2 Availability Zones
* Public and Private subnets (future-ready design)
* Internet Gateway
* Route tables
* Security groups
* EC2 instance in public subnet
* WordPress installation via user-data
* Local MariaDB database on the EC2 instance

### Key Learnings

* Bootstrapping instances with user-data
* Provisioning order and race conditions
* Basic VPC networking
* Parameterizing Terraform variables

---

## Level 2 — Advanced Project

### Objective

Separate application and database by introducing a managed database.

### Changes from Level 1

* Removed local MySQL from EC2
* Added Amazon RDS MySQL instance
* Created DB subnet group across private subnets
* Added DB security group allowing access only from web servers
* Updated user-data to use the RDS endpoint
* Enabled Multi-AZ for database high availability

### Architecture Shift

From:

* Single instance containing app + database

To:

* Stateless compute
* Managed stateful database

### Key Learnings

* Service boundaries
* Private networking patterns
* Security group-to-security group trust
* Dependency management in Terraform

---

## Level 3 — Expert Project

### Objective

Introduce production architecture patterns: private compute, controlled access, autoscaling, and load balancing.

### Implemented Components

#### Bastion Host

* Public EC2 used as the only SSH entry point
* Key forwarding enabled
* Web servers no longer directly accessible

#### NAT Gateway

* Enables private instances to reach the internet for updates and package installation
* Private route table configured with NAT

#### WordPress moved to Private Subnets

* Instances no longer receive public IPs
* Access via Bastion and Load Balancer only

#### Launch Template

* Defines reusable WordPress instance configuration
* Required for autoscaling

#### Application Load Balancer

* Public entry point for HTTP traffic
* Health checks configured
* Routes traffic to WordPress instances

#### Auto Scaling Group

* Multiple WordPress instances across AZs
* Automatic instance replacement on failure
* Integration with ALB target group

#### Removal of Single EC2

* Original EC2 instance deleted
* Infrastructure now managed via templates and scaling policies

### Final Architecture

* Public Layer: ALB + Bastion
* Private Compute Layer: WordPress ASG
* Private Data Layer: RDS
* Outbound Access: NAT Gateway

### Key Learnings

* Zero-trust entry patterns
* High availability design
* Stateless compute model
* Health-based scaling
* Infrastructure lifecycle validation

---

## Deployment Workflow

```bash
terraform init
terraform plan
terraform apply
```

To tear down:

```bash
terraform destroy
```

---

## Operational Validation Performed

* Load balancer traffic remained stable across refreshes
* Terminated an instance to verify autoscaling replacement
* Verified SSH path: Local → Bastion → Private instance
* Confirmed WordPress connectivity to RDS

---

## Current Status

Level 3 core architecture complete.

The environment supports:

* High availability
* Failure recovery
* Private networking
* Managed database
* Horizontal scaling

---

## Purpose of This Project

This project demonstrates understanding of:

* Multi-tier cloud architecture
* Terraform infrastructure design
* AWS networking patterns
* Operational validation and troubleshooting

It represents a progression from single-instance deployments to production-style infrastructure.
