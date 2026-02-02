output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "instance_id" {
  value = aws_instance.main_instance.id
}

output "instance_public_ip" {
  value = aws_instance.main_instance.public_ip
}
