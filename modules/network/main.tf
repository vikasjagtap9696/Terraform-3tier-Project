resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.azs, count.index)
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = var.route_cidr
    gateway_id = aws_internet_gateway.this.id
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  depends_on = [aws_internet_gateway.this]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = var.route_cidr
    nat_gateway_id = aws_nat_gateway.this.id
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "web" {
  name   = var.web_sg_name
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = var.web_from_port
    to_port     = var.web_to_port
    protocol    = var.web_protocol
    cidr_blocks = var.web_cidr_blocks
  }

  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = var.egress_cidr_blocks
  }

  tags = {
    Name = var.web_sg_name
  }
}

resource "aws_security_group" "web_alb" {
  name   = var.web_alb_sg_name
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = var.web_alb_from_port
    to_port     = var.web_alb_to_port
    protocol    = var.web_alb_protocol
    cidr_blocks = var.web_alb_cidr_blocks
  }

  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = var.egress_cidr_blocks
  }

  tags = {
    Name = var.web_alb_sg_name
  }
}

resource "aws_security_group" "app" {
  name   = var.app_sg_name
  vpc_id = aws_vpc.this.id

  ingress {
    from_port       = var.app_from_port
    to_port         = var.app_to_port
    protocol        = var.app_protocol
    security_groups = [aws_security_group.web.id]
  }

  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = var.egress_cidr_blocks
  }

  tags = {
    Name = var.app_sg_name
  }
}

resource "aws_security_group" "db" {
  name   = var.db_sg_name
  vpc_id = aws_vpc.this.id

  ingress {
    from_port       = var.db_from_port
    to_port         = var.db_to_port
    protocol        = var.db_protocol
    security_groups = [aws_security_group.app.id]
  }

  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = var.egress_cidr_blocks
  }

  tags = {
    Name = var.db_sg_name
  }
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}

output "web_sg_id" {
  value = aws_security_group.web.id
}

output "web_alb_sg_id" {
  value = aws_security_group.web_alb.id
}

output "app_sg_id" {
  value = aws_security_group.app.id
}

output "db_sg_id" {
  value = aws_security_group.db.id
}

output "private_db_subnets" {
  value = aws_subnet.private[*].id
}
