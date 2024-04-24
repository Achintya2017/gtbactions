resource "aws_key_pair" "ec2_key01" {
  key_name   = "${var.key_name}01"
  public_key = file("${path.module}/ec2_key01.pub")
}
