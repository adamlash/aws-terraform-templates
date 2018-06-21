# Security Groups

##### HTTP and Required VPC Access for Frontend Servers
resource "aws_security_group" "ec2http" {
name        = "${var.vpcmod_clientname}-EC2-HTTP"
description = "HTTP and HTTPS Access for EC2"
vpc_id      = "${aws_vpc.vpc.id}"

  # HTTP access from anywhere
  ingress {
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }
  # HTTPS Production access from anywhere
 ingress {
   from_port    = 443
   to_port      = 443
   protocol     = "tcp"
   cidr_blocks  = ["0.0.0.0/0"]
  }
  # outbound internet access
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
#####Bastion Management SG
resource "aws_security_group" "management" {
  name        = "${var.vpcmod_clientname}-EC2-Management"
  description = "RDP Access from Anywhere for Server Management"
  vpc_id      = "${aws_vpc.vpc.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#####Internal Management SG
resource "aws_security_group" "intmanagement" {
  name        = "${var.vpcmod_clientname}-EC2-InternalManagement"
  description = "RDP Access from Internal VPC for Server Management"
  vpc_id      = "${aws_vpc.vpc.id}"

  # SSH access from vpc
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["${aws_vpc.vpc.cidr_block}"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#####Internal Open SG
resource "aws_security_group" "intopen" {
  name        = "${var.vpcmod_clientname}-EC2-InternalOpen"
  description = "All Ports Open Internal VPC and Onsite"
  vpc_id      = "${aws_vpc.vpc.id}"

  # access from vpc
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${aws_vpc.vpc.cidr_block}"]
  }
  # access from Onsite
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.159.9.0/24"]
  }
  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

####ICMP Access
resource "aws_security_group" "icmp" {
  name        = "${var.vpcmod_clientname}-EC2-ICMP"
  description = "ICMP Access"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    protocol = "icmp"
    from_port = -1
    to_port = -1
    cidr_blocks = ["0.0.0.0/0"]
   }
   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }
}
#####NAT Instance SG
resource "aws_security_group" "nat" {
  name        = "${var.vpcmod_clientname}-EC2-NAT"
  description = "NAT Access for Private Subnets"
  vpc_id      = "${aws_vpc.vpc.id}"

  # SSH access from VPC
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_vpc.vpc.cidr_block}"]
  }

  # HTTP access from VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${aws_vpc.vpc.cidr_block}"]
  }
  # HTTPS access from VPC
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_vpc.vpc.cidr_block}"]
  }

  # outbound HTTP access
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # outbound HTTPS access
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
