module "ec2_backup" {
  source = "../../modules/ec2-backup"

  ami_id        = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"
  backup_role_name  = "terraform-dev-backup-role"
  backup_vault_name = "terraform-dev-backup-vault"
  backup_plan_name  = "terraform-dev-backup-plan"

  tags = {
    Name = "terraform-vm"
    Env  = "dev"
  }
}

