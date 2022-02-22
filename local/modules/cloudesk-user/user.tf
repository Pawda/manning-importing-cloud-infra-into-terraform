resource "aws_iam_user" "user" {
  name = "${var.name}-terraform"

  tags = {
    managed-by = "manning-terraform"
    workflow = "3.1 - specific resource"
  }
}
