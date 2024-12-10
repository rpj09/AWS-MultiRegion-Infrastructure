resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidrs)
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  vpc_id            = var.vpc_id
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  vpc_id            = var.vpc_id
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}
