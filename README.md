# Terraform code to deploy three-tier architecture on azure

Three Tier architecture deployment pattern in Azure
The Solution includes Web tier Servers, Application tier Servers and Database Tier Servers running in Azure. 
Template follows Standard best practices for running a 3 tier Linux IaaS workload on Azure. This template will deploy specified number of VMs in each tier as per requirement.



## Problem Statement

1. One virtual network tied to three subnets.
2. Each subnet will have one virtual machine.
3. First virtual machine -> Configure network security group rules to allow inbound traffic from internet only.
4. Second virtual machine -> Configure network security group rules to allow traffic from first virtual machine only and can reply the same virtual machine again.
5. App can connect to database and database can connect to app but database cannot connect to web.

Note: Keep main and variable files different for each component_

## Solution

### The Terraform resources will consists of following structure

```
├── main.tf                   // The primary entrypoint for terraform resources.
├── vars.tf                   // It contain the declarations for variables.
├── output.tf                 // It contain the declarations for outputs.
├── terraform.tfvars          // The file to pass the terraform variables values.
 -- terraform.tf               // backend config to store statefile in remote storage (Azure Blob strorage)
```

### Module

A module is a container for multiple resources that are used together. Modules can be used to create lightweight abstractions, so that you can describe your infrastructure in terms of its architecture, rather than directly in terms of physical objects.

For the solution, we have created and used five modules:
1. resourcegroup - creating resourcegroup
2. networking - creating azure virtual network and required subnets
3. securitygroup - creating network security group, setting desired security rules and associating them to subnets
4. compute - creating availability sets, network interfaces and virtual machines
5. database - creating database server and database

All the azure related resources are placed in the modules folder and the variable are stored under **terraform.tfvars**

To run the code you need to append the variables in the terraform.tfvars

Each module consists minimum two files: main.tf, vars.tf

resourcegroup and networking modules consists of one extra file named output.tf

## Deployment
Pre-Requisites: 
How to test Terraform template locally
Create a new folder "local" folder. This folder will not be committed to git.

Create two files in "local" folder:

                variables.tfvars
                backend-config.tfvars
C
Add configuration to backend-config.tfvars:(dont commit these files to repo)

            storage_account_name = "nameofyourstorageaccount"
            container_name       = "blob_container_name"
            key                  = "blob_file_name"
            access_key           = "storage_account_access_key"
Login to azure with az login (or) Add azure_client_secret variable to the variables.tfvars file to authenticate to your Azure environment. In order to obtain client secret, you need to create new service principal in Azure.



### Steps

**Step 0** `terraform init`

used to initialize a working directory containing Terraform configuration files

Run the following commands in the root directory to initialize terraform locally and see what changes are going to be applied.

             terraform init -backend-config="backend-config.tfvars"

**Step 1** `terraform validate`

validates the configuration files in a directory, referring only to the configuration and not accessing any remote services such as remote state, provider APIs, etc

**Step 2** `terraform plan`

used to create an execution plan

**Step 3** `terraform apply`

used to apply the changes required to reach the desired state of the configuration
