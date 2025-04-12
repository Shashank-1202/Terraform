resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "publicsubnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_new

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "privatesubnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_new

  tags = {
    Name = "Private Subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "IGW"
  }
}

resource "aws_route_table" "second_rt" {
 vpc_id = aws_vpc.main.id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.igw.id
 }
 
 tags = {
   Name = "2nd Route Table"
 }
}

resource "aws_route_table_association" "RTasso" {
  subnet_id      = var.public_subnet_new
  route_table_id = aws_route_table.second_rt.id
  map_public_ip_on_launch = true
}

resource "aws_security_group" "SG" {
  name        = "SG"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.aws_vpc

  tags = {
    Name = "SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ipv4" {
  security_group_id = aws_security_group.SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "ipv4_new" {
  security_group_id = aws_security_group.SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_key_pair" "keypair" {
  key_name   = "keypair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIEYyV2IIj50St5hdeA1YPcxQsUxqo6ssoIh+pU/1Mi4+/Hd6YvJHon3atotoSVGBrmhZdGzpLhAHNGZz/QDIhvSZAN5j6uTP6PifnxdwIReNxMEhn0ViFUEV869KL6ZP4HEPModl5/3LiNwAmYoRU00TRb77ZlpMm7iFC7AixRWIobFy5yfbh4p9bDhpOBtVgxWF5uhh5PDE4wrVC2r6rVvqDhXynJUVua2JYX7CTiUeOq2yCjNwSWFi9cg2ioG3ZbFx01Bf/ld028X10r0+5xHM22GxLH+zEkysD1y84/sHW70q1mqFFjIxmaIW2iI5Iy7KywXg9eJq9LiTlF7tp kubernetes"
}

resource "aws_instance" "ec2" {
    ami                    = "ami-084568db4383264d4"  # Ensure this is a valid AMI for your region
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.publicsubnet.id # Use Subnet ID instead of CIDR block
  vpc_security_group_ids = [aws_security_group.SG.id]  # Attach the security group
  key_name               = aws_key_pair.keypair.id  # Attach the key pair for SSH access

  associate_public_ip_address = true  # Assign a public IP (if needed)
  
  tags = {
    Name = "MyEC2Instance"
  }
}
