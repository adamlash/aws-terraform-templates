# Specify the provider, keys and region
provider "aws" {
  region        = "${var.vpcmod_region}"
}

## VPC
# Create a VPC to launch our instances into
resource "aws_vpc" "vpc" {
  cidr_block             = "${var.vpcmod_aws_vpc_cidr}"
  tags  {
      Name      = "${var.vpcmod_clientname}-VPC-1"
      StackName           = "${var.vpcmod_stack_name}"
      Environment          = "${var.vpcmod_env_name}"
      Module               = "./vpc"
      Creator              = "${var.vpcmod_creator} via Terraform"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags  {
      Name                 = "${var.vpcmod_clientname}-IGW"
      StackName           = "${var.vpcmod_stack_name}"
      Environment          = "${var.vpcmod_env_name}"
      Module               = "./vpc"
      Creator              = "${var.vpcmod_creator} via Terraform"
  }
}

## Routes
# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}

# Private Route Table
resource "aws_route_table" "private_route" {
  vpc_id                = "${aws_vpc.vpc.id}"
  route {
      cidr_block  = "0.0.0.0/0"
      instance_id = "${aws_instance.nat.id}"
  }
  tags  {
      Name      = "${var.vpcmod_clientname}-Private Route Table"
      StackName           = "${var.vpcmod_stack_name}"
      Environment          = "${var.vpcmod_env_name}"
      Module               = "./vpc"
      Creator              = "Precision IT via Terraform"
  }
  depends_on           = ["aws_subnet.pub_a"]
}
## Subnets
# Create our subnets to launch our instances into
# Public
resource "aws_subnet" "dmz_a" {
   vpc_id                  = "${aws_vpc.vpc.id}"
   cidr_block              = "${var.vpcmod_aws_dmz_a_subnet}"
   map_public_ip_on_launch = true
   availability_zone       = "${var.vpcmod_aws_az_a}"
   tags  {
      Name                 = "${var.vpcmod_clientname}-DMZ Subnet A"
      StackName           = "${var.vpcmod_stack_name}"
      Environment          = "${var.vpcmod_env_name}"
      Module               = "./vpc"
      Creator              = "${var.vpcmod_creator} via Terraform"
  }
}
resource "aws_subnet" "dmz_b" {
   vpc_id                  = "${aws_vpc.vpc.id}"
   cidr_block              = "${var.vpcmod_aws_dmz_b_subnet}"
   map_public_ip_on_launch = true
   availability_zone       = "${var.vpcmod_aws_az_b}"
   tags  {
     Name                 = "${var.vpcmod_clientname}-DMZ Subnet B"
     StackName           = "${var.vpcmod_stack_name}"
     Environment          = "${var.vpcmod_env_name}"
     Module               = "./vpc"
     Creator              = "${var.vpcmod_creator} via Terraform"
  }
}
resource "aws_subnet" "dmz_c" {
   vpc_id                  = "${aws_vpc.vpc.id}"
   cidr_block              = "${var.vpcmod_aws_dmz_c_subnet}"
   map_public_ip_on_launch = true
   availability_zone       = "${var.vpcmod_aws_az_c}"
   tags  {
     Name                 = "${var.vpcmod_clientname}-DMZ Subnet C"
     StackName           = "${var.vpcmod_stack_name}"
     Environment          = "${var.vpcmod_env_name}"
     Module               = "./vpc"
     Creator              = "${var.vpcmod_creator} via Terraform"
  }
}
# Private
resource "aws_subnet" "pub_a" {
   vpc_id                  = "${aws_vpc.vpc.id}"
   cidr_block              = "${var.vpcmod_aws_pub_a_subnet}"
   map_public_ip_on_launch = true
   availability_zone       = "${var.vpcmod_aws_az_a}"
   tags  {
      Name                 = "${var.vpcmod_clientname}-Public Subnet A"
      StackName           = "${var.vpcmod_stack_name}"
      Environment          = "${var.vpcmod_env_name}"
      Module               = "./vpc"
      Creator              = "${var.vpcmod_creator} via Terraform"
  }
}
resource "aws_subnet" "pub_b" {
   vpc_id                  = "${aws_vpc.vpc.id}"
   cidr_block              = "${var.vpcmod_aws_pub_b_subnet}"
   map_public_ip_on_launch = true
   availability_zone       = "${var.vpcmod_aws_az_b}"
   tags  {
     Name                 = "${var.vpcmod_clientname}-Public Subnet B"
     StackName           = "${var.vpcmod_stack_name}"
     Environment          = "${var.vpcmod_env_name}"
     Module               = "./vpc"
     Creator              = "${var.vpcmod_creator} via Terraform"
  }
}
resource "aws_subnet" "pub_c" {
   vpc_id                  = "${aws_vpc.vpc.id}"
   cidr_block              = "${var.vpcmod_aws_pub_c_subnet}"
   map_public_ip_on_launch = true
   availability_zone       = "${var.vpcmod_aws_az_c}"
   tags  {
     Name                 = "${var.vpcmod_clientname}-Public Subnet C"
     StackName           = "${var.vpcmod_stack_name}"
     Environment          = "${var.vpcmod_env_name}"
     Module               = "./vpc"
     Creator              = "${var.vpcmod_creator} via Terraform"
  }
}
# DB
resource "aws_subnet" "priv_a" {
   vpc_id                  = "${aws_vpc.vpc.id}"
   cidr_block              = "${var.vpcmod_aws_priv_a_subnet}"
   map_public_ip_on_launch = false
   availability_zone       = "${var.vpcmod_aws_az_a}"
   tags  {
      Name                 = "${var.vpcmod_clientname}-Private Subnet A"
      StackName           = "${var.vpcmod_stack_name}"
      Environment          = "${var.vpcmod_env_name}"
      Module               = "./vpc"
      Creator              = "${var.vpcmod_creator} via Terraform"
  }
}
resource "aws_subnet" "priv_b" {
   vpc_id                  = "${aws_vpc.vpc.id}"
   cidr_block              = "${var.vpcmod_aws_priv_b_subnet}"
   map_public_ip_on_launch = false
   availability_zone       = "${var.vpcmod_aws_az_b}"
   tags  {
     Name                 = "${var.vpcmod_clientname}-Private Subnet B"
     StackName           = "${var.vpcmod_stack_name}"
     Environment          = "${var.vpcmod_env_name}"
     Module               = "./vpc"
     Creator              = "${var.vpcmod_creator} via Terraform"
  }
}
resource "aws_subnet" "priv_c" {
   vpc_id                  = "${aws_vpc.vpc.id}"
   cidr_block              = "${var.vpcmod_aws_priv_c_subnet}"
   map_public_ip_on_launch = false
   availability_zone       = "${var.vpcmod_aws_az_c}"
   tags  {
     Name                 = "${var.vpcmod_clientname}-Private Subnet C"
     StackName           = "${var.vpcmod_stack_name}"
     Environment          = "${var.vpcmod_env_name}"
     Module               = "./vpc"
     Creator              = "${var.vpcmod_creator} via Terraform"
  }
}
# Route Associations
resource "aws_route_table_association" "private_route_priv_a" {
    subnet_id      = "${aws_subnet.priv_a.id}"
    route_table_id = "${aws_route_table.private_route.id}"
}
resource "aws_route_table_association" "private_route_priv_b" {
    subnet_id      = "${aws_subnet.priv_b.id}"
    route_table_id = "${aws_route_table.private_route.id}"
}
resource "aws_route_table_association" "private_route_priv_c" {
    subnet_id      = "${aws_subnet.priv_c.id}"
    route_table_id = "${aws_route_table.private_route.id}"
}
resource "aws_route_table_association" "private_route_pub_a" {
    subnet_id      = "${aws_subnet.pub_a.id}"
    route_table_id = "${aws_route_table.private_route.id}"
}
resource "aws_route_table_association" "private_route_pub_b" {
    subnet_id      = "${aws_subnet.pub_b.id}"
    route_table_id = "${aws_route_table.private_route.id}"
}
resource "aws_route_table_association" "private_route_pub_c" {
    subnet_id      = "${aws_subnet.pub_c.id}"
    route_table_id = "${aws_route_table.private_route.id}"
}
## Instances
# Create NAT Instance
resource "aws_instance" "nat" {
    ami                      = "${var.vpcmod_aws_nat_ami}"
    availability_zone        = "${var.vpcmod_aws_az_a}"
    instance_type            = "t2.micro"
    key_name                 = "${var.vpcmod_key_name}"
    vpc_security_group_ids   = ["${aws_security_group.nat.id}"]
    subnet_id                = "${aws_subnet.dmz_a.id}"
    associate_public_ip_address = true
    source_dest_check        = false
  tags  {
      Name                 = "${var.vpcmod_clientname}-NATGW-1"
      StackName           = "${var.vpcmod_stack_name}"
      RoleDescription = "AmznLin - NAT Instance for Internet Access from Private Subnets"
      Environment          = "${var.vpcmod_env_name}"
      Module               = "./vpc"
      Creator              = "${var.vpcmod_creator} via Terraform"
  }

}

resource "aws_eip" "nat" {
	instance = "${aws_instance.nat.id}"
	vpc      = true
}
