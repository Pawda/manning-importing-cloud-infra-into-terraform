resource "aws_iam_user" "user" {
  name = "${var.name}-terraform-workspace"

  tags = {
    managed-by = "manning-terraform"
    workflow = "4.1 - workflow connect"
  }
}

output "user_name" {
  value = aws_iam_user.user.name
}

output "user_arn" {
  value = aws_iam_user.user.arn
  sensitive = true
}
