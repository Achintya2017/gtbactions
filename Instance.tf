resource "aws_instance" "lab_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ec2_key01.key_name
  vpc_security_group_ids = ["${aws_security_group.ec2_01_sg.id}"]
  subnet_id              = "subnet-0ab7a0e5aa40c9323"
  tags = {
    Name = "Lab Instance"
  }

  # This is user data script
    user_data = file("${path.module}/install.sh")

  provisioner "file" {
    source      = "readme.md"
    destination = "/home/ubuntu/"
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("${path.module}/ec2_key01")
    }
  }
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > publicIP.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "ipconfig > ipconfig.output",
      "echo 'hello Amit Charungoo' >>ipconfig.output",
      "cat /etc/os-release >> ipconfig.output",
      "mv ipconfig.output readme.md"
      ]
        connection {
            type = "ssh"
            host = self.public_ip
            user = "ubuntu"
            private_key =  file("${path.module}/ec2_key01")
        }
  
  }

  # provisioner "remote-exec" {
  #    script  = "${path.module}/install.sh"
  # }

  # provisioner "remote-exec" {
  #   script = "./telnet.sh"
  #    connection {
  #           type = "ssh"
  #           host = self.public_ip
  #           user = "ubuntu"
  #           private_key =  file("${path.module}/ec2_key01")
  #       }
  # }
  # provisioner "local-exec" {
  #       on_failure = continue
  #       command = <<-EOT
  #       scp -i ${path.module}/ec2_key01 ubuntu@` 
  #       cat ./publicIP.txt`:/home/ubuntu/readme.md .
  #     EOT
  # }

}


