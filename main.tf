terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "4.5.0"
        }
    }
  required_version = ">= 0.12"
}

provider "aws" {
    region = "us-east-2"
    # aws_secret_access_key = "9kgx3ivbFuXz0hcZFFGVkXxuBkWc+3YAWcZ1fvXe"
    # aws_access_key_id = "AKIAS67QWQCMWGW3VBCU"
}
# // IAM Policies.........................................................................................................................
# resource "aws_iam_role" "lambda_role" {
# name   = "terraform_Lambda_Function_Role"
# assume_role_policy = <<EOF
# {
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Action": "sts:AssumeRole",
#      "Principal": {
#        "Service": "lambda.amazonaws.com"
#      },
#      "Effect": "Allow",
#      "Sid": ""
#    }
#  ]
# }
# EOF
# }
# resource "aws_iam_policy" "iam_policy_for_lambda" {
 
#  name         = "aws_iam_policy_for_terraform_aws_lambda_role"
#  path         = "/"
#  description  = "AWS IAM Policy for managing aws lambda role"
#  policy = <<EOF
# {
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Action": [
#        "logs:CreateLogGroup",
#        "logs:CreateLogStream",
#        "logs:PutLogEvents"
#      ],
#      "Resource": "arn:aws:logs:*:*:*",
#      "Effect": "Allow"
#    }
#  ]
# }
# EOF
# }
# resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
#  role        = aws_iam_role.lambda_role.name
#  policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
# }

# resource "aws_iam_role_policy_attachment" "multiple_iam_policies_attachment" {
#   for_each = toset([
#      # Works with AWS Provided policies too!
#     "arn:aws:iam::aws:policy/AmazonS3FullAccess",
#     "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
#     "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
#     "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess",
#     "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess",
#     "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess",
#     "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess",
#     "arn:aws:iam::aws:policy/CloudWatchFullAccess"
#   ])
  
#   role        = aws_iam_role.lambda_role.name
#   policy_arn  = each.value
# }

# //IAM SERVICE ROLE FOR CODEBUILD............................................
# resource "aws_iam_role" "servicerole-codebuild" {
# name = "servicerole-codebuild"
# assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "codebuild.amazonaws.com"        
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF
# }

# //Code commit.....................................................................................................................
# resource "aws_codecommit_repository" "terraform_repo" {
#   repository_name = "terraform_repository"
# }

# //Code Build................................................................................................................

# resource "aws_s3_bucket" "terraform-codebuild-s3" {
#   bucket = "terraform-codebuild-s3"
# }

# resource "aws_s3_bucket_acl" "terraform-codebuild-s3" {
#   bucket = aws_s3_bucket.terraform-codebuild-s3.id
#   acl    = "private"
# }
# resource "aws_codebuild_project" "terraform-codebuild" {
#   name          = "terraform-codebuild"
#   description   = "terraform_codebuild_project"
#   build_timeout = "5"
#   service_role  = aws_iam_role.servicerole-codebuild.arn

#   artifacts {
#     type = "NO_ARTIFACTS"
#   }

#   cache {
#     type     = "S3"
#     location = aws_s3_bucket.terraform-codebuild-s3.bucket
#   }

#   environment {
#     compute_type                = "BUILD_GENERAL1_SMALL"
#     image                       = "aws/codebuild/standard:1.0"
#     type                        = "LINUX_CONTAINER"
#     image_pull_credentials_type = "CODEBUILD"
#   }

#   logs_config {
#     cloudwatch_logs {
#       group_name  = "log-group"
#       stream_name = "log-stream"
#     }

#     s3_logs {
#       status   = "ENABLED"
#       location = "${aws_s3_bucket.terraform-codebuild-s3.id}/build-log"
#     }
#   }

#   source {
#     type            = "CODECOMMIT"
#     location        = "https://git-codecommit.us-east-2.amazonaws.com/v1/repos/terraform_repository"
#     git_clone_depth = 1

#     git_submodules_config {
#       fetch_submodules = true
#     }
#   }

#   source_version = "branch"

#   tags = {
#     Environment = "Test"
#   }
# }


# //Creating two Lambda Functions.........................................................................................................
 
# resource "aws_lambda_function" "Terraform_order_simulator" {
# filename                       = "${path.module}/python/order_simulator.zip"
# function_name                  = "Terraform_order_simulator"
# role                           = aws_iam_role.lambda_role.arn
# handler                        = "order_simulator.lambda_handler"
# runtime                        = "python3.8"
# depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
# }
# resource "aws_lambda_function" "Terraform_order_processor" {
# filename                       = "${path.module}/python/order_processor.zip"
# function_name                  = "Terraform_order_processor"
# role                           = aws_iam_role.lambda_role.arn
# handler                        = "order_processor.lambda_handler"
# runtime                        = "python3.8"
# depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
# }


# ///creating SQS queue...................................................................................................................

# resource "aws_sqs_queue" "terraform_queue" {
#   name                      = "terraform-standard-queue"
#   delay_seconds             = 0
# #   max_message_size          = 256
# #   message_retention_seconds = 86400
#   receive_wait_time_seconds = 0
#   sqs_managed_sse_enabled = true
#   redrive_policy = jsonencode({
#         deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter.arn
#         maxReceiveCount     = 1
#   })
#   tags = {
#     Environment = "production"
#   }
# }

# /////Dead-Letter QUEUE......................................................................................................

# resource "aws_sqs_queue" "terraform_queue_deadletter" {
#   name = "terraform-deadletter-queue"
# }
# //Adding Lambda Trigger to SQS...................................................................................................
# resource "aws_lambda_event_source_mapping" "event_source_mapping" {
#   batch_size        = 1
#   event_source_arn  = "${aws_sqs_queue.terraform_queue.arn}"
#   enabled           = true
#   function_name     = "${aws_lambda_function.Terraform_order_processor.arn}"
# }

# ////DYNAMODB TABLE......................................................................................................................

# resource "aws_dynamodb_table" "Terraform_DYNAMODB_ORDERS_TABLE" {
#  name = "Terraform_DYNAMODB_ORDERS_TABLE"
#  billing_mode = "PROVISIONED"
#  read_capacity= "30"
#  write_capacity= "30"
#  range_key      = "order_details"
#  hash_key       = "id"

#   attribute {
#     name = "id"
#     type = "N"
#   }

#   attribute {
#     name = "order_details"
#     type = "S"
#   }
# }

