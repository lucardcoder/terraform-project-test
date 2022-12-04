# Terraform-Project-Team1

In your AWS account: 
## 1. create S3 bucket with name of "tfstate-<Account_ID>" in region "us-east-1"

## 2. create DynamoDB table name of "tfstate-team1" with LockID key

## 3. Under main>VPC>backend.tf change "tfstate-*******" to "tfstate-<Account_ID>"
## 4. To run:
```
make build
```
## 5. To destroy:
```
make destroy
```