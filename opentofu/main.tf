provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "my_app" {
  ami           = "ami-0df7a207adb9748c7"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = {
    Name = "next.sj app"
  }
}

resource "aws_security_group" "app_sg" {
  provider = aws

  # Allow HTTP (web)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH (remote access)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}