## Terraform Module Project

This repository contains Terraform modules to manage infrastructure resources in AWS, specifically EC2 instances, subnets, and VPCs. The modules are designed to be reusable and configurable for easy deployment and management.

```sh
Terraform Module project
├── main.tf
├── modules
│   ├── ec2
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variable.tf
│   ├── subnet
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variable.tf
│   └── vpc
│       ├── main.tf
│       ├── output.tf
│       └── variable.tf
├── provider.tf
├── terraform.tfvars
└── variable.tf

```

**main.tf**: The entry point for the Terraform configuration. This file calls the modules to create resources and sets up basic infrastructure.

**modules/**: A folder containing reusable Terraform modules:

**ec2/**: Module for managing EC2 instances.

**subnet/**: Module for creating subnets.

**vpc/**: Module for setting up VPCs.

**provider.tf**: Contains provider configurations (e.g., AWS) and region settings.

**terraform.tfvars**: Contains the values of variables that Terraform will use during the run.

**variable.tf**: Defines the input variables used throughout the configuration.



### Module Details


**EC2 Module**

This module is used to create EC2 instances.


*Input variables*:

**instance_type**: The instance type to create (e.g., t2.micro).

**ami_id**: The AMI ID to use for the EC2 instance.

**key_name**: The name of the SSH key for accessing the instance.



*Outputs*:

**instance_id**: The ID of the created EC2 instance.

**public_ip**: The public IP address of the EC2 instance.



#Subnet Module


This module is used to create subnets in your VPC.

*Input variables*:

**vpc_id**: The ID of the VPC where the subnet will be created.

**cidr_block**: The CIDR block for the subnet.



*Outputs*:

**subnet_id**: The ID of the created subnet.

**subnet_cidr_block**: The CIDR block of the created subnet.



*VPC Module*

This module is used to create a VPC.


*Input variables*:

**cidr_block**: The CIDR block for the VPC.


*Outputs*:

**vpc_id**: The ID of the created VPC.

**cidr_block**: The CIDR block of the created VPC.