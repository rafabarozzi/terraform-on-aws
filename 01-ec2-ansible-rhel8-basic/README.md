# Provisioning EC2 Instance and Install AWX

## Prerequisites

- Terraform *https://www.terraform.io/downloads.html*
- AWS CLI *https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html*
- AWS EC2 Keypair *https://docs.aws.amazon.com/servicecatalog/latest/adminguide/getstarted-keypair.html*
## Resources created

- 1 EC2 Instance (RHEL8) m5.larger with Public IP
- 2 Security Groups (SSH and Web)
- 1 EBS volume of 200 GB for AWX use

## How to Use

1. Clone the repository: Clone this repository to your local machine using the following command:

```
git clone https://github.com/rafabarozzi/terraform-on-aws.git
```

2. Navigate to correct folder

```
cd 01-ec2-ansible-rhel8-basic/terraform-manifest
```

3. Copy your Key pair to Folder *private-key*

4. Edit the Files

```
t2-varibles.tf
Configure your KeyPair
```

5. Initialize Terraform

```
terraform init
```

6. Run code verification

```
terraform plan
```

7. Apply the Terraform configuration

```
terraform apply -auto-approve
```

**Access AWX using the EC2 Public IP.**

*Example: http://44.80.220.64*

- **User:** *admin*
- **Pass:** *password*

8. Destroy the infrastructure

```
terraform destroy -auto-approve
```

**Please be cautious while using the *terraform destroy* command, as it will permanently delete the resources provisioned by Terraform.**
