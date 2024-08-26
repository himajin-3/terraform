
####################
# vpc
####################
resource "aws_vpc" "main" {
  cidr_block           = var.vpc
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${local.name_prefix}-${local.Environment}-vpc"
  }
}

####################
# subnet
####################
# プライベートサブネット作成
resource "aws_subnet" "private_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "${local.name_prefix}-${local.Environment}-private-1a"
  }
}

# パブリックサブネット作成
resource "aws_subnet" "public_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "${local.name_prefix}-${local.Environment}-public-1a"
  }
}
####################
# route table
####################
# private_ルートテーブル作成
resource "aws_route_table" "private_1a" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "${local.name_prefix}-${local.Environment}-private-1a"
  }
}

# private_ルートテーブル紐づけ
resource "aws_route_table_association" "private_1a" {
  subnet_id      = aws_subnet.private_1a.id
  route_table_id = aws_route_table.private_1a.id
}

####################
# route table
####################
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "IGW"
  }
}

# public_ルートテーブル作成
resource "aws_route_table" "public_1a" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "${local.name_prefix}-${local.Environment}-public-1a"
  }
}

# public_ルートテーブル紐づけ
resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_route_table.public_1a.id
}





