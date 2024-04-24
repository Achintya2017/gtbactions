variable "ami" {
  description = "The AMI to use for the server instances."
  default     = ""
}

variable "instance_type" {
  description = "The type of server instance to launch."
  default     = "t2.micro"
}


variable "key_name" {
  description = "Name of AWS Key Pair that can be used to SSH to the ec2"
}

variable "aws_sg" {
  description = "AWS Security Group ID()s to associate with this resource and apply to it."
  type        = list(number)
  default     = []
}
