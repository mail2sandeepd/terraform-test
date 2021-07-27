provider "aws" {
    region = "us-east-2"
}

variable "app" {
    type = string
    default = "web"
}
data "aws_ami" "amazon-linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20210701*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Amazon
}
data "aws_vpc" "myvpc" {
    filter {
    name   = "tag:Name"
    values = ["Defa*"]
  }
}

output "VPC_ID" {
 value = data.aws_vpc.myvpc.id
}

data "aws_subnet" "pri-subnet" {
  vpc_id = data.aws_vpc.myvpc.id
  filter {
    name   = "tag:Name"
    values = ["pri*"]
  }
}

output "Private_Subnet" {
 value = data.aws_subnet.pri-subnet.id
}

data "aws_subnet" "pub-subnet" {
  vpc_id = data.aws_vpc.myvpc.id
  filter {
    name   = "tag:Name"
    values = ["pub*"]
  }
}

output "Public_Subnet" {
 value = data.aws_subnet.pub-subnet.id
}

resource "aws_instance" "sandeep-server-1" {
 ami = data.aws_ami.amazon-linux.id
 instance_type = "t2.micro"
 subnet_id = "${var.app == "web" ? data.aws_subnet.pub-subnet.id : data.aws_subnet.pri-subnet.id }"
  tags = {
    Name = "Sandeep-prod-instance1"
    Env = "Prod"
    app = var.app
  }
}
