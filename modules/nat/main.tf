resource "aws_eip" "nat" {
  count  = length(var.public_subnet_ids) 
  domain = "vpc"

  tags = {
    Name = "NAT Gateway EIP for Public Subnet ${count.index + 1}"
  }
}

resource "aws_nat_gateway" "gw" {
  count        = length(var.public_subnet_ids) 
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = element(var.public_subnet_ids, count.index)

  tags = {
    Name = "NAT Gateway for Public Subnet ${count.index + 1}"
  }
}
