# product-expo

Let us start building the infrastructure
So Lets Start by installing terraform
# Step 1 : 
Install the terrafom.
# Step 2 : 
create a main.tf configuration file and add aws provider in it.We should never pass the any secrets and access key, so for that configure the aws credentials in locally. Open the terminal, go to the folder and open the config file and paste the access key and secret key like show below.Open the aws IAM Console -> click on users -> create a user and after that open security credentials, in that we can see our accesskey, and for secret key it will show only once, download it, then copy the scret and access key paste in terminal.
# Step 3 : 
Create a file which contains all the configurations related to codecommit which should be .tf type. Using aws_codecommit_repository resource it can create a repository for us. Provide a repository name.
# Step 4 : 
Before going to next step,we need create and setup a Service role that can allow the build to execute all services such as lambda,sqs, dynamobd,deploy, cloudwatch for logs and all the required iam permissions. We add json format policies and also we can direct add the services which allows all thepermissions of the policies.
# Step 5 : 
Next Create a file for Codebuild. Provide all the neccesary attributes such as build name, artifacts, source and service role that contain required iam permissions, make sure all the permissions are provided are not. Below is the code for my c odebuild.
# Step 6 : 
Create a another file which contains all the configurations related to code deploy. Provide all the required attribute fileds. Next For Code Deploy we need to create a Deployment_group also with deployment_style, make sure providing a correct lambda deployment_style which is blue/green by providing required permissions.
# Step 7 :
Create a pipeline which contains all the three stages which source ,build, deploy. For that, Create a another configuration file which contains all the confirguration data. Artifact_store is required to store our files in s3 bucket.Adding Commit stage by specifiying all the configuration which we did in codecommit file. Make sure that use the Source catagory as Source and Branchname as u have, here i have master and provide a codecommit repository arn.
Adding Build Stage with the project name that we created previous in configuration section.Adding the Deploy stagewith the Aplication and deployment_group that we created previous in codedeploy configuration file.Before going to console and start the pipeline we need to create a buildspec.yaml file for codebuild. Here is my buildspec.yaml file.
And also need to appspec.yaml file codedeploy is required. We will talk about this later, for now just add 2 stages that are codecommit and codebuild.So, Now go to the Console And check all the resources are created or not with all the configurations the we specifiedCodecommit repository.Codebuild projectCodeDeploy Application, Note: Don’t add Codedeploy in the pipeline as a stage for now, we can configure this later, but we see now it will create a deployment group and application.
We can also check the IAM roles and policies that will created by terraform.Now we can start the pipeline, Before that make sure the buildspec yaml file is there.
# Step 8 :
Create a configuration file which will create an SNS Topic and Subscription to the pipeline.Now Go to Simple Notification Service(SNS) console -> Click on TopicsWe can see that terrform created an sns topic for us.Now For subscription, it will senda subscription mail to us, by clicking subscribe in the mail, it will add to the subscription status as confirmed.Now By visiting our codepipeline, Click on Notify -> click on manage notification rule -> click on Notifications we can a rule that is created. It will send a notifications based on the events that we cofigure in the terraform file, for this it will sends a notifications to our mail whenever the pipeline execution fails.
Developers can be notified via email if their build fails It willbe usefull whenever we are working on teams.So Finally, We completed the all the things that are in the below serverless architeture.
# So what are the usecases of it, Use cases of Decoupled serverless architecture Use case 1: If a team has been given a mandate to recommend an upgrade for the backend architecture to prepare for the upcoming Thanksgiving sale. Historically, our company has seen a 5X traffic spike for e-commerce for the duration of this sale. In the past, there have been cases where the system went down and customer orders were lost, leading to significant revenue loss for the company. We need you to devise a decoupled serverless backend architecture thatis able to handle the spike in traffic for the duration of the sale. This solution, we will leverage an SQS standard queue to send, store, and receive order messages and then configure the SQS Event Source to trigger the Lambda function which in turn processes the orders into a DynamoDB table.use case 2: The Engineering team at a company has raised an issue. Every time a developer commits their code to the repository, they have to manually trigger a single EC2 instance-based Jenkins pipeline to build and test the code. Often, the Jenkins server slows down and stops responding, resulting in a lot of time wastage. This approach is a time-consuming task for the developers. They would just like to focus on pushing their application code to the Git repository, and the rest should be taken care of automatically by a more stable pipeline. Bycreating an automated pipeline using AWS services that can achieve this. In addition, developers should be notified via email if their build fails.
