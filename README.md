Note : All the code files and documentation are provided in this repo.
###### For clear understanding , visit the product documentaion which is shared here or u can visit https://amedeloitte-my.sharepoint.com/personal/pnirosha_deloitte_com/_layouts/15/onedrive.aspx?login_hint=pnirosha%40deloitte%2Ecom&FolderCTID=0x0120001FE62EDB963FA9428BBCF6A7CE04EA47&id=%2Fpersonal%2Fpnirosha%5Fdeloitte%5Fcom%2FDocuments%2FMicrosoft%20Teams%20Chat%20Files%2FFinalized%2Dproduct%2Ddoc%20%281%29%2Epdf&parent=%2Fpersonal%2Fpnirosha%5Fdeloitte%5Fcom%2FDocuments%2FMicrosoft%20Teams%20Chat%20Files
# Step 1 :
Install the terrafom. 

- wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
- echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | 
  sudo tee/etc/apt/sources.list.d/hashicorp.list
- sudo apt update && sudo apt install terraform

 

 

 

# Step 2 :  
create a main.tf configuration file and add aws provider in it. 

 

 

 

 

 

 

We should never pass the any secrets and access key, so for that configure the aws credentials in locally. Open the terminal, go to the folder and open the config file and paste the access key and secret key like show below. 

###### Open the aws IAM Console -> click on users -> create a user and after that open security credentials,  in that we can see our accesskey, and for secret key  it will show only once, download it, then copy the scret and access key paste in terminal. 

  

 

# Step 3 : 
Create a file which contains all the configurations related to codecommit which should be .tf type. Using aws_codecommit_repository resource it can create a repository for us. Provide a repository name. 

 

 

 

 

 

 

# Step 4 : 
Before going to next step,we need create and setup a Service role that can allow the build to execute all services such as lambda,sqs, dynamobd,deploy, cloudwatch for logs and all the required iam permissions. We add json format policies and also we can direct add the services which allows all the permissions of the policies. 

 

  

 

 

 

 

 

 

 

 

 

 

 

# Step 5 : 
Next Create a file for Codebuild. Provide all the neccesary attributes such as build name, artifacts, source and service role that contain required iam permissions, make sure all the permissions are provided are not. Below is the code for my codebuild. 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

# Step 6 : 
Create a another file which contains all the configurations related to code deploy. Provide all the required attribute fileds. Next For Code Deploy we need to create a Deployment_group also with deployment_style, make sure providing a correct lambda deployment_style which is blue/green by providing required permissions. 

 

 

 

 

 

 

 

 

# Step 7 : 
Create a pipeline which contains all the three stages which source , build, deploy. For that, Create a another configuration file which contains all the confirguration data. Artifact_store is required to store our files in s3 bucket. 

Adding Commit stage by specifiying all the configuration which we did in codecommit file. Make sure that use the Source catagory as Source and Branchname as u have, here i have master and provide a codecommit repository arn.  

 

 

 

 

 

 

 

 

 

 

 

 

 

 

Adding Build Stage with the project name that we created previous  in configuration section.  

 

 

 

 

 

 

 

 Adding the Deploy stage with the Aplication and deployment_group that we created previous in codedeploy configuration file. 

 

 

 

 

 

 

 

 

 

Before going to console and start the pipeline we need to create a buildspec.yaml file for codebuild. Here is my buildspec.yaml file. 

 

 

 

 

 

 

 

 

 

 

And also need to appspec.yaml file codedeploy is required. We will talk about this later, for now just add 2 stages that are codecommit and codebuild. 

So, Now go to the Console And check all the resources are created or not with all the configurations the we specified 

Note: Don’t add Codedeploy in the pipeline as stage, we can configure this later, but we see now it will create a deployment group and application. 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

Now we can start the pipeline, Before that make sure the buildspec yaml file is there. 

 

 

 

# Step 8 : 
Before Creating a lamda functions, create a IAM role and add required policies to the lambda which will allows the lambda function to communicate other resources. So lets create a file, that it contain all the iam configuration for lamda function. 

 

 

 

 

 

 

 

 

 

 

 

 

# Step 9 :  
Create a configuration file that contains all the required configuration that can create a lambda function. Before that we need to zip our lambda function , for this i am using python3.8 for function code 

Before that, here i have TWO lambda functions one is order_simulator.py and other one order_processor.py  

 

 

 

 

 

 

 

 

 

 

 

 

 

Let’s understand what all these function doing. 

For order_simulator lambda functon – it will sends all our messages to the SQS with specified order. We need to mention QUEUE_URL... 

 

 

 

 

 

 

 

 

 

 

 

 

For order_processor lamda function – it will process the messages that are stored in sqs and it sends to all the valid messages to the Dynamodb 

 

 

 

 

 

 

 

 

 

 

 

 

# Step 10 : 
So Lets create an SQS queue  and dead_letter_queue for storing invalid or bad data. For that create a configuration file which contians the sqs resource configuration. 

 

 

 

 

 

 

 

 

 

 

 

 

 

Now first go to IAM console, Click on roles and our terraform lambda role is created by terraform 

 

 

Now click on the terraform_lambda_function_role, we can see all the policies are attached to the role which we specified in the configuration file. 

 

 

 

 

 

Now go to lambda console , terraform created two lambda function with specified configuration. 

 

Now,  Click the simulator function we can see our code. 

  

 

 

 

 

Now click alias , we can see our alias function also. 

 

Now clicking our Terraform_order_processor function we can see that it added the sqs as trigger. 

 

Now, Go to the sqs console, terraform is created two queues for us one for valid data.,  

 

 

Now open the terraform_standard_queue, By clicking Lambda triggers we can see that terraform added the our order_processor lambda function 

 

By clicking Dead letter queues, we can see that terraform added the our dead_lead_letter_queue  

 

 

 

 

# Step 11 : 
Now create a file for DynamoDB configuration and add the required attributes such as name attributes rangekey and hashkey.. 

 

 

 

 

 

  

 

 

 

After Going to DynamoDB console, Click Tables,Now we can see our table 

 

 

# Step 12 : 
Now Test our lambda Function With valid and invalid input. 

For this, Go to Lambda Console,  -> click Fucntions -> 

Open Terraform_order_simulator -> click Test -> Configure test event -> create a new event -> give a name and  pass the valid json data -> click Save -> Click Test 

 

 

After Click on Test 

 

After Testing Successfully,  

If any Failures occurs while testing the function, make sure fuction has required iam policies to excute sqs and Dynamodb, make sure we are passing the correct SQS url and correct Dynamodb Table name in the function python code. 

 

 

Now Go to DynamoDB console -> Click on Tables -> click on our table which is Terraform_DYNAMODB_ORDERS_TABLE 

 

We can the our data is stored in dynamodb which is processed by our order_processor lambda function. 

Now try to pass the duplicate or invalid data. 

Here i am passing the price as a string format, which not allowed because we specified price as float value. So let’s try 

Click on save and Test. 

After Executing successfully, 

 

Go to SQS console -> click on Queues -> click on our dead_letter_queue which is Terraform-dead-letter-queue -> Click on Send and receive messages -> Now at the bottom we can see poll for messages Click on poll messages  

 

If any failures occcures, like not  appearing the messages to the dead letter queue, try to increase the latency of standard queue. latency for Dead letter queue is minimum 10. maximum receives parameter had 10 value, So it was proccessing 10 times.. 11 time if not processed it puts to DLQ. Change the latency to one , then you can see immadiate invalid data in dead-letter queue. 

 

We can see our invalid values are stored. Now click on one messages to see our values. After click on Done. 

 

Also, we could check Cloudwatch logs for the information being logged there: 

We can check by directly going to cloudwatch console or By  

Going back to the lambda console and click on the ‘Monitor’ tab. Then click on the ‘View logs in CloudWatch’ button. This will open a new tab and take you to CloudWatch. 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

By clicking latest event logs we can see all the things that are proccessed by a order_procesor lambda function. 

 

# Step 13 : 
Create a configuration file which will create an SNS Topic and Subscription to the pipeline. 

Now Go to Simple Notification Service(SNS) console -> Click on Topics 

We can see terrform created an sns topic for us. 

 

Now For subscription, it will send a subscription mail to us, by clicking subscribe in the mail, it will add to the subscription status as confirmed . 

 

Developers can be notified via email if their build fails It will be usefull whenever we are working on teams. 

  

 

So Finally, We completed the all the things that are in the below serverless architeture. 

So what are the usecases of it,  

## Use cases of Decoupled serverless architecture  

 

Use case 1:  

If a team has been given a mandate to recommend an upgrade for the backend architecture to prepare for the upcoming Thanksgiving sale. Historically, our company has seen a 5X traffic spike for e-commerce for the duration of this sale. In the past, there have been cases where the system went down and customer orders were lost, leading to significant revenue loss for the company. We need you to devise a decoupled serverless backend architecture that is able to handle the spike in traffic for the duration of the sale.  

This solution, we will leverage an SQS standard queue to send, store, and receive order messages and then configure the SQS Event Source to trigger the Lambda function which in turn processes the orders into a DynamoDB table. 

use case 2:  

The Engineering team at a company has raised an issue. Every time a developer commits their code to the repository, they have to manually trigger a single EC2 instance-based Jenkins pipeline to build and test the code. Often, the Jenkins server slows down and stops responding, resulting in a lot of time wastage. This approach is a time-consuming task for the developers. They would just like to focus on pushing their application code to the Git repository, and the rest should be taken care of automatically by a more stable pipeline.  

By creating an automated pipeline using AWS services that can achieve this. In addition, developers should be notified via email if their build fails. 

 
