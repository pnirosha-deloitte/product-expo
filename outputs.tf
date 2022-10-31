# output "code_commit_repo" {
#     description = "code commit repo"
#     value = aws_codecommit_repository.terraform_repo.repository_name
# }
# output "code_pipeline_stages" {
#     description = "code pipeline details"
#     value = aws_codepipeline.terraform-codepipeline.stage
# }
# output "code_pipeline_id" {
#     description = "code pipeline details"
#     value = aws_codepipeline.terraform-codepipeline.id
# }
# output "code_pipeline_arn" {
#     description = "code pipeline details"
#     value = aws_codepipeline.terraform-codepipeline.arn
# }
# output "lambda_function1_name" {
#     description = "lambda function names"
#     value =  aws_lambda_function.Terraform_order_simulator.function_name
# }
# output "lambda_function2_name" {
#     description = "lambda function names"
#     value =  aws_lambda_function.Terraform_order_processor.function_name
# }
# output "function1_arn" {
#   description = "function arn"
#   value = aws_lambda_function.Terraform_order_simulator.invoke_arn
# }
# output "function2_arn" {
#   description = "function arn"
#   value = aws_lambda_function.Terraform_order_processor.invoke_arn
# }
# output "sqs_details" {
#     description = "sqs triggers"
#     value = aws_sqs_queue.terraform_queue.arn
# }
# output "sqs_url" {
#     description = "sqs url"
#     value = aws_sqs_queue.terraform_queue.url
# }
# output "lambda_description" {
#     description = "lambda_description"
#     value = aws_lambda_function.Terraform_order_processor.description
# }
# output "aws_lambda_alias" {
#     description = "lambda alias function description"
#     value = aws_lambda_alias.Terraform_order_simulator_lambda_alias.description
# }
# output "dynamodb_arn" {
#     description = "dynamodb_arn"
#     value = aws_dynamodb_table.Terraform_DYNAMODB_ORDERS_TABLE.arn
# }
# output "dynamodb_Table_attributes" {
#     description = "dynamodb_Table_attributes"
#     value = aws_dynamodb_table.Terraform_DYNAMODB_ORDERS_TABLE.attribute
# }
# output "dynamodb_Table_haskey" {
#     description = "dynamodb_Table_hashkey"
#     value = aws_dynamodb_table.Terraform_DYNAMODB_ORDERS_TABLE.hash_key
# }
# output "dynamodb_Table_rangekey" {
#     description = "dynamodb_Table_rangekey"
#     value = aws_dynamodb_table.Terraform_DYNAMODB_ORDERS_TABLE.range_key
# }
# output "sns_subscription_id" {
#     description = "sns subscription id"
#     value = aws_sns_topic_subscription.sns-topic.id  
# }
# output "sns_subscription_owner" {
#     description = "sns subscription owner"
#     value = aws_sns_topic_subscription.sns-topic.owner_id
# }
# output "sns_arn" {
#     description = "sns_arn"
#     value = aws_sns_topic.terraform_notif.arn
# }
# output "sns_owner" {
#     description = "sns_owner"
#     value = aws_sns_topic.terraform_notif.owner
# }