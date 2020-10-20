provider "aws" {
  version         = "~> 2.7"
  profile         = var.aws_profile
  region          = var.aws_region
  assume_role {
    role_arn      = var.aws_role
  }
}
