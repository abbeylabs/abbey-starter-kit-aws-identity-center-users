data "aws_ssoadmin_instances" "main" { }

resource "aws_organizations_account" "staging" {
  name = "Staging"
  email = "koushik+aws1@abbey.io"
}

resource "aws_organizations_account" "production" {
  name = "Production"
  email = "koushik+aws_test_prod1@abbey.io"
}
