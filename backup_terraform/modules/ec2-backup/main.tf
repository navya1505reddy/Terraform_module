resource "aws_instance" "vm" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = merge(
    var.tags,
    {
      Backup = "true"
    }
  )
}

resource "aws_iam_role" "backup_role" {
  name = var.backup_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "backup.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "backup_policy" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_iam_role_policy_attachment" "restore_policy" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}

resource "aws_backup_vault" "vault" {
  name = var.backup_vault_name
}

resource "aws_backup_plan" "plan" {
  name = var.backup_plan_name

  rule {
    rule_name         = "daily-midnight-backup"
    target_vault_name = aws_backup_vault.vault.name
    schedule          = var.backup_schedule

    lifecycle {
      delete_after = var.backup_retention_days
    }
  }
}

resource "aws_backup_selection" "selection" {
  name         = "ec2-backup-selection"
  plan_id      = aws_backup_plan.plan.id
  iam_role_arn = aws_iam_role.backup_role.arn

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "true"
  }
}

