// IAM Policies.........................................................................................................................
resource "aws_iam_role" "lambda_role" {
name   = "terraform_Lambda_Function_Role"
assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "multiple_iam_policies_attachment" {
  for_each = toset([
     # Works with AWS Provided policies too!
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
    "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess",
    "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess",
    "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess",
    "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess",
    "arn:aws:iam::aws:policy/CloudWatchFullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess",
    "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
  ])
  
  role        = aws_iam_role.lambda_role.name
  policy_arn  = each.value
}

//IAM SERVICE ROLE FOR CODEBUILD............................................
resource "aws_iam_role" "servicerole-codebuild" {
name = "servicerole-codebuild"
assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com",
        "Service": "events.amazonaws.com",
        "Service": "lambda.amazonaws.com",
        "Service": "codecommit.amazonaws.com",
        "Service": "codebuild.amazonaws.com",
        "Service": "codepipeline.amazonaws.com",
        "Service": "codedeploy.amazonaws.com",
        "Service": "sqs.amazonaws.com",
        "Service": "sns.amazonaws.com",
        "Service": "dynamodb.amazonaws.com"
      }
    }
  ]
}
EOF
}
