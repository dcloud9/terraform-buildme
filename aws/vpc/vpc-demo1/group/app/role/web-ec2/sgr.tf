# Allow SSH from Bastion
resource "aws_security_group_rule" "sgr_ingress_tcp_22_bastion" {
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 22
  to_port                  = 22
  source_security_group_id = "${data.terraform_remote_state.role_bastion.role_sg_id}"
  security_group_id        = "${aws_security_group.sg.id}"
}

# Allow HTTPS/443 from WWW
resource "aws_security_group_rule" "sgr_elb_ingress_tcp_443_www" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb_sg.id}"
}

# Allow HTTP/80 from WWW
resource "aws_security_group_rule" "sgr_elb_ingress_tcp_80_www" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb_sg.id}"
}

# Allow tcp/80 from ELB SG
resource "aws_security_group_rule" "sgr_ingress_tcp_80_elb" {
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = "${aws_security_group.elb_sg.id}"
  security_group_id        = "${aws_security_group.sg.id}"
}