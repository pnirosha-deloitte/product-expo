//CODEPIPELINE...............................................................................................................................
# resource "aws_codepipeline" "terraform-codepipeline" {

#     name = "terraform-codepipeline"
#     role_arn = aws_iam_role.servicerole-codebuild.arn

#     artifact_store {
#         type="S3"
#         location = aws_s3_bucket.terraform-codepipeline-s3.bucket
#     }

#     stage {
#         name = "CodeCommit"
#         action{
#             name = "Source"
#             category = "Source"
#             provider = "CodeCommit"
#             version = "1"
#             owner = "AWS"
#             output_artifacts = ["SourceArtifact"]
#             configuration = {
#                 RepositoryName = aws_codecommit_repository.terraform_repo.repository_name
#                 BranchName   = "master"
#             }
#         }
#     }

#     stage {
#         name ="CodeBuild"
#         action{
#             name = "Build"
#             category = "Build"
#             provider = "CodeBuild"
#             version = "1"
#             owner = "AWS"
#             input_artifacts = ["SourceArtifact"]
#             configuration = {
#                 ProjectName = aws_codebuild_project.terraform-codebuild.name
#             }
#         }
#     }

#     stage {
#         name ="CodeDeploy"
#         action{
#             name = "Deploy"
#             category = "Deploy"
#             provider = "CodeDeploy"
#             version = "1"
#             owner = "AWS"
#             input_artifacts = ["SourceArtifact"]
#             configuration = {
#                 ProjectName = aws_codebuild_project.terraform-codebuild.name
#             }
#         }
#     }

# }

//////////////////////////////////
resource "aws_codepipeline" "terraform-codepipeline" {
  name     = "terraform-codepipeline"
  role_arn = aws_iam_role.servicerole-codebuild.arn

  artifact_store {
    location = aws_s3_bucket.terraform-codepipeline-s3.bucket
    type     = "S3"
  }

  stage {
        name = "CodeCommit"
        action{
            name = "Source"
            category = "Source"
            provider = "CodeCommit"
            version = "1"
            owner = "AWS"
            output_artifacts = ["SourceArtifact"]
            configuration = {
                RepositoryName = aws_codecommit_repository.terraform_repo.repository_name
                BranchName   = "master"
            }
        }
    }

  stage {
    name = "CodeBuild"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = [ "BuildArtifact" ]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.terraform-codebuild.name
      }
    }
  }

  stage {
    name = "CodeDeploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["BuildArtifact"]
      version         = "1"

      configuration = {
        ApplicationName = aws_codedeploy_app.terraform_codedeploy.name
        DeploymentGroupName = aws_codedeploy_deployment_group.terraform_deployment_group.deployment_group_name
        # AppSpecTemplateArtifact = "BuildArtifact"
        # AppspecTemplatePath = "appspec.yaml"
      }
    }
  }
}

