//Code Build................................................................................................................

resource "aws_codebuild_project" "terraform-codebuild" {
  name          = "terraform-codebuild"
  description   = "terraform_codebuild_project"
  build_timeout = "5"
  #service_role  = aws_iam_role.servicerole-codebuild.arn
  service_role  = aws_iam_role.servicerole-codebuild.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.terraform-codepipeline-s3.bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.terraform-codepipeline-s3.id}/build-log"
    }
  }

  source {
    type            = "CODEPIPELINE"
    location        = "https://git-codecommit.us-east-2.amazonaws.com/v1/repos/terraform_repository"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = "refs/heads/master"

  tags = {
    Environment = "Test"
  }
}

resource "aws_s3_bucket" "terraform-codepipeline-s3" {
  bucket = "terraform-codepipeline-s3"
}

resource "aws_s3_bucket_acl" "terraform-codepipeline-s3" {
  bucket = aws_s3_bucket.terraform-codepipeline-s3.id
  acl    = "private"
}