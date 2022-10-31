////DYNAMODB TABLE......................................................................................................................

resource "aws_dynamodb_table" "Terraform_DYNAMODB_ORDERS_TABLE" {
 name = "Terraform_DYNAMODB_ORDERS_TABLE"
 billing_mode = "PROVISIONED"
 read_capacity= "30"
 write_capacity= "30"
 range_key      = "order_details"
 hash_key       = "id"

  attribute {
    name = "id"
    type = "N"
  }

  attribute {
    name = "order_details"
    type = "S"
  }
}
