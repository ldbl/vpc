resource "aws_instance" "openvpn" {
  ami           = "ami-0b418580298265d5c"
  instance_type = "t2.micro"
  key_name      = "stan"
  subnet_id     = aws_subnet.public-subnet-1.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ec2_public_security_group.id]
  count = 0
  tags = {
    Name = "OpenVPN"
  }
  depends_on = [aws_eip.elastic-ip-for-nat-gw]

}
