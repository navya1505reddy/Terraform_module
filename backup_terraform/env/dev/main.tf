module "ec2_backup" {
  source = "../../modules/ec2-backup"

  ami_id        = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  tags = {
    Name = "terraform-vm"
    Env  = "dev"
  }
}

