terraform {
  backend "s3" {
    bucket         = "talant-dev-infra-backend"
    profile        = "project1"
    # dynamodb_table = "<REPLACE_WITH_YOUR_DYNAMODB_TABLENAME>"
    key            = "infra/eks/terraform-aws-eks-workshop.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}