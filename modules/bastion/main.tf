resource "aws_instance" "bastion" {
  ami             = data.aws_ami.latest_amazon_linux.id
  instance_type   = local.selected_instance_type
  subnet_id       = element(var.public_subnet_ids, 0)
  associate_public_ip_address = true

  tags = {
    Name = "BastionHost"
  }
}

variable "instance_types" {
  description = "List of possible EC2 instance types"
  type        = list(string)
  default     = ["t3.micro", "t3a.micro", "t2.micro", "t2.nano"]
}

locals {
  # Use the lowest instance type from the list
  selected_instance_type = element(var.instance_types, 0)
}

data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}