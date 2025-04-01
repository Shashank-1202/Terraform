output "ec2_instance_id" {
    value = aws_instance.main.public_ip
    description = "The public IP of the EC2 instance"
  
}