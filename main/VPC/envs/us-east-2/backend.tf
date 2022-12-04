terraform {
  backend "s3" {
    bucket  = "tfstate-983909746875"
    key     = "tfstate-team1"
    region  = "us-east-1"
    encrypt = true
  }
}

