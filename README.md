# DevOps Assessment Homework  

![](ECS.png)

## Run the app

In a virtualenv, run:

    python setup.py install FLASK_APP=hello flask run

# Push image updates
```
docker build --platform=linux/amd64 -t hello-app .
docker tag hello-app:latest 303981612052.dkr.ecr.eu-west-2.amazonaws.com/hello-app:latest
docker push 303981612052.dkr.ecr.eu-west-2.amazonaws.com/hello-app:latest
```

# LB DNS
```
hello-lb-59498855.eu-west-2.elb.amazonaws.com
```