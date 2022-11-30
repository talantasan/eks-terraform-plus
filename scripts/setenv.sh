#!/bin/bash
 
# Set current folder
DIR=$(pwd)
 
### Set color
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

BUCKET_NAME=`cat ../terraform.auto.tfvars | grep bucket_name | awk '{print $3}' | tr -d '""'`
MYPROFILE=`cat ../terraform.auto.tfvars | grep myprofile | awk '{print $3}' | tr -d '""'`
MYREGION=`cat ../terraform.auto.tfvars | grep region | awk '{print $3}' | tr -d '""'`

if  [ -z  $BUCKET_NAME ];
then
 echo """
     ${red}Did you add bucket_name  in terraform.auto.tfvars  ${reset}
    
     BUCKET_NAME=YOUR_BUCKET_NAME
     """
 return
else
 echo ${green} "Backend file" ${reset}
cat << EOF > "$DIR/backend.tf"
terraform {
 backend "s3" {
   bucket = "${BUCKET_NAME}"
   profile = "${MYPROFILE}"
   key   = "`echo $PWD | sed s/"\/root\/"//`.tfstate"
   region = "${MYREGION}"
 }
}
EOF
cat "`pwd`/backend.tf"
echo ${red}"************************************"${reset}

echo ${green}"provider file"${reset}
cat << EOF > "$DIR/provider.tf"
provider "kubernetes" {
  config_path    = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

terraform {
  required_version = ">= 0.13"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
  profile = var.myprofile
  # other options for authentication
}

variable "region" {}
variable "myprofile" {}

EOF
cat "`pwd`/provider.tf"
fi



