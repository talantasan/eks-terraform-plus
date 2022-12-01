data "terraform_remote_state" "infra" {
  backend = "s3"
  config = {
    bucket         = "talant-dev-infra-backend"
    key            = "infra/eks/terraform-aws-eks-workshop.tfstate"
    region         = "us-east-1"
    profile        = "project1"
  }
}