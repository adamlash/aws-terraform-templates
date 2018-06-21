provider "aws" {
  region                  = "${var.aws_region}"
  profile                 = "default"
}

##VPC setup
module "vpc" {
  source = "./vpc"
  vpcmod_region         = "${var.aws_region}"
  #VPC Config
  vpcmod_clientname         = "${var.clientname}"
  vpcmod_creator            = "${var.creator}"
  vpcmod_aws_vpc_cidr       = "10.180.28.0/22"
  vpcmod_aws_dmz_a_subnet   = "10.180.28.0/26"
  vpcmod_aws_dmz_b_subnet   = "10.180.28.64/26"
  vpcmod_aws_dmz_c_subnet   = "10.180.28.128/26"
  vpcmod_aws_pub_a_subnet   = "10.180.29.0/26"
  vpcmod_aws_pub_b_subnet   = "10.180.29.64/26"
  vpcmod_aws_pub_c_subnet   = "10.180.29.128/26"
  vpcmod_aws_priv_a_subnet  = "10.180.30.0/26"
  vpcmod_aws_priv_b_subnet  = "10.180.30.64/26"
  vpcmod_aws_priv_c_subnet  = "10.180.30.128/26"
  vpcmod_aws_az_a           = "${var.aws_az_a}"
  vpcmod_aws_az_b           = "${var.aws_az_b}"
  vpcmod_aws_az_c           = "${var.aws_az_c}"
  vpcmod_env_name           = "Production"
  vpcmod_stack_name         = "${var.aws_vpcstackname1}"
  vpcmod_aws_nat_ami        = "ami-e3217a80"
  vpcmod_key_name           = "${var.aws_key_name}"
}
