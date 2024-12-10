resource "aws_route_table" "public" {
    vpc_id = var.vpc_id

    tags = {
    Name = "public-route-table"
    }
}

resource "aws_route_table_association" "public" {
    count          = length(var.public_subnet_cidrs)
    subnet_id      = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

resource "aws_route" "public_internet_access" {
    route_table_id         = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = var.internet_gateway_id
}

resource "aws_route_table" "private" {
    count  = length(var.private_subnet_cidrs)
    vpc_id = var.vpc_id

    tags = {
    Name = "private-route-table-${count.index + 1}"
    }
}

resource "aws_route_table_association" "private" {
    count          = length(var.private_subnet_cidrs)
    subnet_id      = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private[count.index].id
}
