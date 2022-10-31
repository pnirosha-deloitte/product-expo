//Creating two Lambda Functions.........................................................................................................
 
resource "aws_lambda_function" "Terraform_order_simulator" {
filename                       = "${path.module}/python/order_simulator.zip"
function_name                  = "Terraform_order_simulator"
role                           = aws_iam_role.lambda_role.arn
handler                        = "order_simulator.lambda_handler"
runtime                        = "python3.8"
# function_version               = "1"
depends_on                     = [aws_iam_role_policy_attachment.multiple_iam_policies_attachment]
}
resource "aws_lambda_function" "Terraform_order_processor" {
filename                       = "${path.module}/python/order_processor.zip"
function_name                  = "Terraform_order_processor"
role                           = aws_iam_role.lambda_role.arn
handler                        = "order_processor.lambda_handler"
runtime                        = "python3.8"
depends_on                     = [aws_iam_role_policy_attachment.multiple_iam_policies_attachment]
}
//ALIAS FOR CODEDEPLOY..............................
resource "aws_lambda_alias" "Terraform_order_simulator_lambda_alias" {
  name             = "alias"
  function_name    = aws_lambda_function.Terraform_order_simulator.arn
  function_version = "1"
}
resource "aws_lambda_alias" "Terraform_order_processor_lambda_alias" {
  name             = "alias"
  function_name    = aws_lambda_function.Terraform_order_processor.arn
  function_version = "1"
}

