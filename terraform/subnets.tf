
resource "aws_subnet" "public" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_cidr_block, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = merge(var.tags, {
    "Name" = "subnet-${var.name}-public-${element(var.availability_zones, count.index)}"
  })
}

resource "aws_route_table" "public" { # Creating RT for Public Subnet
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = merge(var.tags, {
    "Name" = "rt-${var.name}-public-${data.aws_region.current.name}"
  })
}

resource "aws_route_table_association" "public" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}


resource "aws_internet_gateway" "internet_gateway" { # Creating Internet Gateway
  vpc_id = aws_vpc.main.id                           # vpc_id will be generated after we create VPC
  tags = merge(var.tags, {
    "Name" = "internet-gateway-${var.name}-${data.aws_region.current.name}"
  })
}

resource "aws_subnet" "private" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_cidr_block, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = merge(var.tags, {
    "Name" = "subnet-${var.name}-private-${element(var.availability_zones, count.index)}"
  })
}

resource "aws_route_table" "private" { # Creating RT for Private Subnet
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = merge(var.tags, {
    "Name" = "rt-${var.name}-private-${element(var.availability_zones, count.index)}"
  })
}

resource "aws_route_table_association" "private" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_eip" "nat_ip" {
  count = var.num_nat_gateways
  vpc   = true
  tags = merge(var.tags, {
    "Name" = "nat-ip-${var.name}-${element(var.availability_zones, count.index)}"
  })
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_ip[0].id
  subnet_id     = aws_subnet.public[0].id
  tags = merge(var.tags, {
    "Name" = "nat-gateway-${var.name}-$(var.availability_zones)}"
  })
}
