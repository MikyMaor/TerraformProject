resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "main_vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  count      = var.subnet_count
  cidr_block = "10.0.${count.index}.0/24"
  tags = {
    Name = "main_subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "main_igw"
  }
}

resource "aws_route_table" "main_rt" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "main_rt"
  }
}

resource "aws_route" "main_route" {
  route_table_id         = aws_route_table.main_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_igw.id
}

resource "aws_route_table_association" "main_rta" {
  subnet_id      = aws_subnet.public_subnet[var.subnet_count - 1].id
  route_table_id = aws_route_table.main_rt.id
}

resource "aws_security_group" "main_sg" {
  name        = "main_sg"
  description = "Main security group"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "main_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet[var.subnet_count - 1].id
  security_groups             = [aws_security_group.main_sg.id]
  associate_public_ip_address = var.assign_public_ip
  tags = {
    Name = "main_instance"
  }
}
