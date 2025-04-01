resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "***********************************************"
}


resource "aws_instance" "main" {
   ami = "ami-071226ecf16aa7d96"
   instance_type = "t2.micro"
   key_name      = aws_key_pair.deployer.key_name
   subnet_id = var.subnet_id

   tags = {
     Name = "my_instance"
   }  
}