# Provisioning EC2 Instance with Load Balance/SSL Certificate and Install AWX

## Prerequisites

- Terraform *https://www.terraform.io/downloads.html*
- AWS CLI *https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html*
- AWS EC2 Keypair *https://docs.aws.amazon.com/servicecatalog/latest/adminguide/getstarted-keypair.html*
- DNS registered on Route53 *https://docs.aws.amazon.com/pt_br/Route53/latest/DeveloperGuide/domain-register.html*
- Certificate issued by AWS Certification Manager *https://docs.aws.amazon.com/pt_br/apigateway/latest/developerguide/how-to-custom-domains-prerequisites.html*
## Resources created

- 1 EC2 Instance (RHEL8) m5.larger in a Private Subnet
- 1 EC2 instance (AmazonLinux) t3.micro for Bastion Host in a Public Subnet
- 1 Elastic IP for EC2 Bastion Host
- 2 Security Groups (Private and Public)
- 1 EBS volume of 200 GB for AWX use
- 1 Application Load Balancer
- 1 entry in Route53

## How to Use

1. Clone the repository: Clone this repository to your local machine using the following command:

```
git clone https://github.com/rafabarozzi/terraform-on-aws.git
```

2. Navigate to correct folder

```
cd 01-ec2-ansible-rhel8-lb-ssl/terraform-manifest
```

3. Copy your Key pair to Folder *private-key*

4. Edit the files

```
t6-02-datasource-route53-zone.tf
Configure your Domain

t7-01-ec2instance-variables.tf
Configure your KeyPair

t9-nullresource-provisioners.tf
Configure your KeyPair

t11-acm-certificatemanager.tf
Configure your Domain

t12-route53-dnsregistration
Configure your Domain

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

**Access AWX using the configured domain.**

*Example: https://awx.rbarozzi.com*

- **User:** *admin*
- **Pass:** *password*

8. Destroy the infrastructure

```
terraform destroy -auto-approve
```

**Please be cautious while using the *terraform destroy* command, as it will permanently delete the resources provisioned by Terraform.**
