resource "abbey_grant_kit" "user_admin_center_grant" {
  name = "user_admin_center_grant"
  description = <<-EOT
    Grants membership for an IAM Identity Center managed user
    to an Identity Center managed group.
    This Grant Kit uses a single-step Grant Workflow that requires only a single reviewer
    from a list of reviewers to approve access.    
  EOT

  workflow = {
    steps = [ {
      reviewers = {
        one_of = ["alice@example.com"] #CHANGEME
      }
    } ]
  }

  output = {
    # Replace with your own path pointing to where you want your access changes to manifest.
    # Path is an RFC 3986 URI, such as `github://{organization}/{repo}/path/to/file.tf`.
    location = "github://replace-me-with-organization/replace-me-with-repo/access.tf" #CHANGEME
    append = <<-EOT
      resource "aws_ssoadmin_account_assignment" "prod_full_access_user_${aws_identitystore_user.bob.user_id}" {
        instance_arn       = tolist(data.aws_ssoadmin_instances.main.arns)[0]
        permission_set_arn = aws_ssoadmin_permission_set.compute_full_access.arn

        principal_id = "${aws_identitystore_user.bob.user_id}"
        principal_type = "USER"

        target_id   = aws_organizations_account.production.id
        target_type = "AWS_ACCOUNT"
      }    
    EOT
  }
}

resource "abbey_identity" "user_1" {
  abbey_account = "replace-me@example.com" #CHANGEME
  source = "aws_member"
  metadata = ""
}
