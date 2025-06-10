# DevOps assessment terraform

This is the template you can use to do the Terraform part of the [devops
assessment][1]. Like the other repo, don't fork it, clone it locally and create
your own repo to avoid be listed in the fork list and expose your work to
others.

# URL

## What is expected

We should be able to request the application using the DNS of an external load
balancer on port 80. (443 not needed).

These are the services you have access to:

 * Full ECS permissions
 * Full EC2 permissions
 * Full LoadBalancer (ELB/ELBv2) permissions
 * Full VPC permissions
 * Read-only access to IAM role 'ecsTaskExecutionRole'
 * Permissions to manage IAM credentials for yourself

## Notes

 * A basic working VPC is already in place in AWS, you can build on top of it.
 * You don't have access to S3, so use a local state file or store remote
   states somewhere else.
 * Right now only 2 replicas are accepted due to service limits. Don't try to
   deploy more.
 * Keep in mind that Fargate needs to reach outside the VPC to download the
   containers from ECR. A `CannotPullContainerError` is not only a permission
   error. There are two ways to achieve this, all seem fine to us.
 * There is a role called `ecsTaskExecutionRole` available and can be used as
   execution role of the tasks.
 * Remember that if you're having issues, you can always deploy services
   manually in AWS and then import your resources in terraform.
 * Don't prepare CI/CD workflow for this project, just share the code with us.
 * We encourage you to be verbose and write comments, that will be very useful
   for us, especially if you don't have time to complete the full assessment.

[1]: https://github.com/travelperk/devops-assessment


Task stopped at: 2025-06-05T21:03:45.002Z
ResourceInitializationError: unable to pull secrets or registry auth: The task cannot pull registry auth from Amazon ECR: There is a connection issue between the task and Amazon ECR. Check your task network configuration. RequestError: send request failed caused by: Post "https://api.ecr.eu-west-2.amazonaws.com/": dial tcp 52.94.53.88:443: i/o timeout

> itnernet gateway