provider "aws" {
  region = "ap-northeast-1"  # 適宜リージョンを変更してください
}

# VPCの定義
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# インターネットゲートウェイの定義
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

# パブリックサブネットの定義
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"  # 適宜変更してください
}

# プライベートサブネットの定義
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-1a"  # 適宜変更してください
}

# EIPの定義 (NAT Gateway用)
resource "aws_eip" "nat" {
  vpc = true
}

# NAT Gatewayの定義
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
}

# プライベートルートテーブルの定義
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
}

# プライベートルートテーブルにルートを追加 (NAT Gateway経由)
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

# プライベートサブネットとルートテーブルの関連付け
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# パブリックルートテーブルの定義
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

# パブリックサブネットとルートテーブルの関連付け
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
