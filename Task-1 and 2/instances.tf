resource "aws_instance" "server1" {
  ami                         = "ami-0252d9c82e6b8fa85"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  tags = {
    Name = "server1"
  }
}
