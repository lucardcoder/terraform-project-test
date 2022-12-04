
data "terraform_remote_state" "backend" {
  backend = "s3"
  config = {
    bucket = "tfstate-983909746875"
    key    = "tfstate-team1"
    region = "us-east-1"
  }
}


#data "aws_caller_identity" "current" {}


# data "aws_ami" "this" {
#   most_recent = true
#   owners      = [data.aws_caller_identity.current.account_id]
# }


data "aws_ami" "amazon-linux-2" {
 most_recent = true


 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }


 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}




resource "aws_security_group" "allow_tls" {
  name        = "terraform-testing-alb"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.terraform_remote_state.backend.outputs.vpc_id


  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = var.tags
}


#Create ASG

module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.5.3"
  # Autoscaling group
  name                      = "Project-asg"
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 3
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = [data.terraform_remote_state.backend.outputs.public_subnet1, data.terraform_remote_state.backend.outputs.public_subnet2, data.terraform_remote_state.backend.outputs.public_subnet3]



  # Launch template
  launch_template_name        = "Project-asg"
  launch_template_description = "Launch template example"
  update_default_version      = true
  image_id                    = data.aws_ami.amazon-linux-2.id      #"ami-0b0dcb5067f052a63"
  instance_type               = "t3.micro"
  ebs_optimized               = false
  enable_monitoring           = false
  user_data                   = "IyEvYmluL2Jhc2gKc3VkbyB5dW0gaW5zdGFsbCBodHRwZCAteSAKc3VkbyBzeXN0ZW1jdGwgc3RhcnQgaHR0cGQg"
  target_group_arns           = module.alb.target_group_arns
  security_groups = [
    aws_security_group.allow_tls.id
  ]
  tags = var.tags
}

#Create ALB

module "alb" {
  source                           = "terraform-aws-modules/alb/aws"
  version                          = "~> 8.0"
  name                             = "my-alb"
  load_balancer_type               = "application"
  enable_cross_zone_load_balancing = true
  vpc_id                           = data.terraform_remote_state.backend.outputs.vpc_id
  subnets                          = [data.terraform_remote_state.backend.outputs.public_subnet1, data.terraform_remote_state.backend.outputs.public_subnet2, data.terraform_remote_state.backend.outputs.public_subnet3]


  security_groups = [
    aws_security_group.allow_tls.id
  ]

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
  tags = var.tags
}





