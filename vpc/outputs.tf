#VPC Related Outputs
output "o_vpc_id"        { value = "${aws_vpc.vpc.id}" }
output "o_vpc_cidr"      { value = "${aws_vpc.vpc.cidr_block}" }
#Subnet IDs
output "o_sub_pub_a_id"  { value = "${aws_subnet.pub_a.id}" }
output "o_sub_pub_b_id"  { value = "${aws_subnet.pub_b.id}" }
output "o_sub_pub_c_id"  { value = "${aws_subnet.pub_c.id}" }
output "o_sub_priv_a_id"   { value = "${aws_subnet.priv_a.id}"  }
output "o_sub_priv_b_id"   { value = "${aws_subnet.priv_b.id}"  }
output "o_sub_priv_c_id"   { value = "${aws_subnet.priv_c.id}"  }
output "o_sub_dmz_a_id"   { value = "${aws_subnet.dmz_a.id}"  }
output "o_sub_dmz_b_id"   { value = "${aws_subnet.dmz_b.id}"  }
output "o_sub_dmz_c_id"   { value = "${aws_subnet.dmz_c.id}"  }
#Security Group IDs
output "o_sg_nat"        { value = "${aws_security_group.nat.id}" }
output "o_sg_management" { value = "${aws_security_group.management.id}" }
output "o_sg_intmanagement" { value = "${aws_security_group.intmanagement.id}" }
output "o_sg_intopen" { value = "${aws_security_group.intopen.id}" }
output "o_sg_icmp" { value = "${aws_security_group.icmp.id}" }
