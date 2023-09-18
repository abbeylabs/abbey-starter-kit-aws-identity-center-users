resource "aws_identitystore_user" "bob" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.main.identity_store_ids)[0]

  display_name = "Bob Builder"
  user_name    = "bob"

  name {
    given_name  = "Bob"
    family_name = "Builder"
  }

  emails {
    value = "koushik+bob@abbey.io"
  }
}