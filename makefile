build:
		cd main/VPC && terraform init && terraform apply -var-file dev.tfvars -auto-approve

		cd main/ASG && terraform init && terraform apply -var-file dev.tfvars -auto-approve

destroy:


		cd main/ASG &&  terraform destroy -var-file dev.tfvars -auto-approve

		cd main/VPC &&  terraform destroy -var-file dev.tfvars -auto-approve


# build-ohio:

# 		cd main/ASG/envs/us-east-2 && terraform init && terraform apply -var-file env.tfvars -auto-approve

# 		cd main/VPC/envs/us-east-2 && terraform init && terraform apply -var-file env.tfvars -auto-approve


# destroy-ohio:

# 		cd main/ASG/envs/us-east-2 terraform destroy -var-file env.tfvars -auto-approve

# 		cd main/VPC/envs/us-east-2 terraform destroy -var-file env.tfvars -auto-approve





# build-all:
# 		make build && make build-ohio

# destroy-all:
# 		make destroy && make destroy-ohio