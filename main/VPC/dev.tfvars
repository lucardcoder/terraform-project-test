cidr_block         = "10.0.0.0/16"
public_subnet1     = "10.0.1.0/24"
public_subnet2     = "10.0.2.0/24"
public_subnet3     = "10.0.3.0/24"
private_subnet1    = "10.0.101.0/24"
private_subnet2    = "10.0.102.0/24"
private_subnet3    = "10.0.103.0/24"
region             = "us-east-1"
enable_nat_gateway = false
# access_key = "YOUR_AWS_ACCESS_KEY"  ## provide only if your VM does not have administrator IAM role attached.
# secret_key = "YOUR_AWS_SECRET_KEY"  ## provide only if your VM does not have administrator IAM role attached.

tags = {
  Name = "Terraform-project"
  Team = "Team-1"
}