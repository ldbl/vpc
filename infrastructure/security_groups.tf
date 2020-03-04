resource "aws_security_group" "ec2_public_security_group" {
  name        = "EC2-Public-SG"
  description = "Internet reaching access for EC2 instances"
  vpc_id      = aws_vpc.production-vpc.id

  ingress {
    from_port   = 1194
    protocol    = "TCP"
    to_port     = 1194
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]   # put own ip here when demonstrating
  }

  //  ingress {
  //    from_port   = 0
  //    protocol    = "-1"
  //    to_port     = 0
  //    cidr_blocks = ["0.0.0.0/0"]
  //  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ec2_private_security_group" {
  name        = "EC2-Private-SG"
  description = "Only allow public EC2 instances to access these instances"
  vpc_id      = aws_vpc.production-vpc.id

  ingress {
    from_port       = 0
    protocol        = "-1"
    to_port         = 0
    security_groups = ["${aws_security_group.ec2_public_security_group.id}"]
  }

  ingress {
    from_port = 1194
    protocol = "TCP"
    to_port = 1194
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow traffic for health checking, remember this doesnt allow public internet!"
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "elb_security_group" {
  name        = "ELB-SG"
  description = "ELB Security Group"
  vpc_id      = aws_vpc.production-vpc.id

  ingress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow web traffic to load balancer"
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
