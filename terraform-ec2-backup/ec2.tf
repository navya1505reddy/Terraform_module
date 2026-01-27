resource "aws_instance" "vm" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name   = "terraform-vm"
    Backup = "true"
  }
}
