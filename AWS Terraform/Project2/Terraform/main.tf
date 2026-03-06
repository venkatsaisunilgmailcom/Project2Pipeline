
 data "aws_key_pair" "existing_key"{
     key_name               = "New_KeyPair"
  }
resource "aws_instance" "Pipeline_Instance" {
  instance_type          = "t3.micro"
  ami                    = "ami-0f3caa1cf4417e51b"
  key_name               = data.aws_key_pair.existing_key.key_name
    user_data = <<EOF
#!/bin/bash
yum update -y
yum install docker -y
systemctl start docker
systemctl enable docker

aws ecr get-login-password --region us-east-1 \
| docker login --username AWS --password-stdin 299149745114.dkr.ecr.us-east-1.amazonaws.com

docker pull ${var.docker_image}
docker run -d -p 80:80 ${var.docker_image}
EOF
  

  vpc_security_group_ids = ["sg-03e4f476ac3735dee"]

  tags = {
    Name = "jenkins-docker-server"
  }
}



