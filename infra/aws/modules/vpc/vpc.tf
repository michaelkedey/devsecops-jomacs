#vpc
resource "aws_vpc" "project_vpc" {
  cidr_block = var.cidrs["vpc"]
  provider   = aws.project_region

  tags = merge(
    var.tags_all,
    {
      Name = var.names["vpc"]
    }
  )
}

#public subnet 1
resource "aws_subnet" "project_public_subnet" {
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = var.cidrs["public_subnet"]
  provider          = aws.project_region
  availability_zone = var.azs[0]

  tags = merge(
    var.tags_all,
    {
      Name = var.names["public_subnet"]
    }
  )
}

resource "aws_subnet" "project_public_subnet1" {
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = var.cidrs["public_subnet1"]
  provider          = aws.project_region
  availability_zone = var.azs[1]

  tags = merge(
    var.tags_all,
    {
      Name = var.names["public_subnet1"]
    }
  )
}

#private subnet
resource "aws_subnet" "project_private_subnet" {
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = var.cidrs["private_subnet"]
  provider          = aws.project_region
  availability_zone = var.azs[0]

  tags = merge(
    var.tags_all,
    {
      Name = var.names["private_subnet"]
    }
  )
}

#eip needed to work with the nat gateway
resource "aws_eip" "project_eip" {
  #instance = var.instance_id
}

#nat gateway
resource "aws_nat_gateway" "project_nat_gateway" {
  allocation_id = aws_eip.project_eip.id
  subnet_id     = aws_subnet.project_public_subnet.id

  tags = merge(
    var.tags_all,
    {
      Name = var.names["nat_gateway"]
    }
  )
  depends_on = [aws_internet_gateway.project_internet_gateway]
}

#internet gateway
resource "aws_internet_gateway" "project_internet_gateway" {
  vpc_id = aws_vpc.project_vpc.id
  tags = merge(
    var.tags_all,
    {
      Name = var.names["internet_gateway"]
    }
  )
}


#public route table
resource "aws_route_table" "project_public_route_table" {
  vpc_id = aws_vpc.project_vpc.id
  route {
    cidr_block = var.cidrs["default_route"]
    gateway_id = aws_internet_gateway.project_internet_gateway.id
  }

  tags = merge(
    var.tags_all,
    {
      Name = var.names["public_route_table"]
    }
  )
}

#associate public rt with public subnet
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.project_public_subnet.id
  route_table_id = aws_route_table.project_public_route_table.id
}

#associate public rt with public subnet1
resource "aws_route_table_association" "public_association1" {
  subnet_id      = aws_subnet.project_public_subnet1.id
  route_table_id = aws_route_table.project_public_route_table.id
}

#private route table
resource "aws_route_table" "project_private_route_table" {
  vpc_id = aws_vpc.project_vpc.id
  route {
    cidr_block     = var.cidrs["default_route"]
    nat_gateway_id = aws_nat_gateway.project_nat_gateway.id
  }

  tags = merge(
    var.tags_all,
    {
      Name = var.names["private_route_table"]
    }
  )
}

#associate private rt with private subnet
resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.project_private_subnet.id
  route_table_id = aws_route_table.project_private_route_table.id
}
