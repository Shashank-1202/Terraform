module "vpc" {
   source = "./modules/vpc"
   vpc_name = "var.vpc_name"
   vpc_cidr = "var.vpc_cidr"
}

module "subnet" {
    source = "./modules/subnet"
    vpc_id = module.vpc.vpc_id
    public_cidr = "var.public_cidr"
  
}

module "ec2" {
    source = "./modules/ec2"
    subnet_id = module.subnet.public_subnet
    instance_type = "var.instance_type"

}