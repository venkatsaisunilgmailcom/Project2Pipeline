
 data "aws_key_pair" "existing_key"{
     key_name               = "New_KeyPair"
  }
resource "aws_instance" "Pipeline_Instance" {
  instance_type          = "t3.micro"
  ami                    = "ami-0f3caa1cf4417e51b"
  key_name               = data.aws_key_pair.existing_key.key_name

  vpc_security_group_ids = ["sg-03e4f476ac3735dee"]

  tags = {
    Name = "jenkins-docker-server"
  }
}



