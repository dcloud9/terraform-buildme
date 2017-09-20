resource "aws_key_pair" "kp" {
  key_name   = "kp-${var.environment}-${var.environment_vpc}"
  public_key = "${var.public_key}"
}