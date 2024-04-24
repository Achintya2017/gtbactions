resource "aws_security_group" "ec2_01_sg" {
  name        = "ec2_01"
  description = "Security group for EC2 instances"

  dynamic "ingress" {
    for_each = var.aws_sg
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# description = "Security Group for EC2 Instance in ${var.project} Project
