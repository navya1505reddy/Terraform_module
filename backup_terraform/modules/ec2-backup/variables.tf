variable "ami_id" {
  type        = string
  description = "AMI ID for EC2"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "backup_role_name" {
  type    = string
  default = "terraform-dev-backup-role"
}

variable "backup_vault_name" {
  type    = string
  default = "terraform-dev-backup-vault"
}

variable "backup_plan_name" {
  type    = string
  default = "terraform-dev-backup-plan"
}

variable "backup_schedule" {
  type    = string
  default = "cron(0 0 * * ? *)"
}

variable "backup_retention_days" {
  type    = number
  default = 7
}

