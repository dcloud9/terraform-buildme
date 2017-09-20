# Allow SSH from whitelisted IPs
resource "aws_security_group_rule" "sgr_ingress_tcp_22_Internet" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.sg.id}"
}
