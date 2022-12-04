output "vpc_id" {
  value = data.terraform_remote_state.backend.outputs.vpc_id
}