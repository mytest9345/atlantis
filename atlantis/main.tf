provider "aws" {
  region     = "eu-central-1"
  profile    = "default"
}
terraform {
  backend "s3" {
    bucket  = "test-atlantis"
    key     = "atlantis/terraform.tfstate"
    region  = "eu-central-1"
    profile = "default"
  }
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-atlantis"
  }
}
