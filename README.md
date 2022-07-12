# SunilUdacityProject5
[![CircleCI](https://dl.circleci.com/status-badge/img/gh/mrsunilmehta/SunilUdacityProject5/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/mrsunilmehta/SunilUdacityProject5/tree/main)


## Project Overview

In this project I have appied the skills and knowledge which were developed throughout the Cloud DevOps Nanodegree program. These include:

1. Working in AWS
2. Using Jenkins or Circle CI to implement Continuous Integration and Continuous Deployment
3. Building pipelines using circleci
4. Working with Ansible and CloudFormation to deploy clusters
5. Building Kubernetes clusters
6. Building Docker containers in pipelines

### Project Tasks

Your project goal is to operationalize this working, machine learning microservice using [kubernetes](https://kubernetes.io/), which is an open-source system for automating the management of containerized applications. In this project I did:
* Test your project code using linting
* Complete a Dockerfile to containerize this application
* Deploy your containerized application using Docker and make a prediction
* Configure Kubernetes and create a Kubernetes cluster
* Deploy a container using Kubernetes and make a prediction
* Upload a complete Github repo with CircleCI to indicate that your code has been tested


**The final implementation of the project will showcase your abilities to operationalize production microservices.**

---

### Requirements

* CircleCI
* AWS EKS (Kubernetes)
* [**circleci/aws-eks@1.1.0s**](https://circleci.com/developer/orbs/orb/circleci/aws-eks)
* [**circleci/kubernetes@0.4.0**](https://circleci.com/developer/orbs/orb/circleci/kubernetes)

1. Create the CircleCI account
2. Create a GitHub repository

## Install

1. Download or clone this project
2. Push this project to your GitHub repository
3. In CircleCI setup the project.
Once on the Project page, find the project you are using and click Set Up Project.

![set up project](https://github.com/mrsunilmehta/SunilUdacityProject5/blob/main/Screenshots/Circleci%20project.jpg)

According to the AWS EKS orb’s repo it is very important to meet these requirements before running the pipeline:

Add the AWS credentials as environment variables. Configure `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` and `AWS_DEFAULT_REGION` as CircleCI project or context environment variables as shown in the links provided for [project](https://circleci.com/docs/2.0/env-vars/#setting-an-environment-variable-in-a-project) or [context](https://circleci.com/docs/2.0/env-vars/#setting-an-environment-variable-in-a-context).

![create environment variables](https://github.com/mrsunilmehta/SunilUdacityProject5/blob/main/Screenshots/Circleci%20Env%20Variables.jpg)

Add the policies to the IAM user suggested in the official eksctl website as [Minimum IAM policies](https://eksctl.io/usage/minimum-iam-policies/)


## Setup the Environment

* Create a virtualenv with Python 3.7 and activate it. Refer to this link for help on specifying the Python version in the virtualenv. 
```bash
python3 -m pip install --user virtualenv
# You should have Python 3.7 available in your host. 
# Check the Python path using `which python3`
# Use a command similar to this one:
python3 -m virtualenv --python=<path-to-Python3.7> .virtualenv
source .virtualenv/bin/activate
```
* Run `make install` to install the necessary dependencies

* Create a virtualenv and activate it
   ```
   python3 -m venv virtualenv
   . virtualenv/bin/activate
   ```
* Run `make install` to install the necessary dependencies
  ```
  pip install --upgrade pip &&\
	pip install -r requirements.txt &&\
	sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
	sudo chmod +x /bin/hadolint
  ```

## Lint the App `make lint`
  ```
  hadolint Dockerfile --ignore DL4000
	pylint --disable=R,C,W1203,W1202 app.py
  ```

## Push image to Docker hub
[Image public URL](https://hub.docker.com/r/mrsunilmehta/project5)

## Creating the infrastructure using orbs circleci/aws-eks@1.0.3
  ```
  aws-eks/create-cluster:
        cluster-name: sunil-eks-cluster
  ```

## Creating the deployment steps with aws-eks/python3 executor
  ```
  - kubernetes/install
  - aws-eks/update-kubeconfig-with-authenticator:
      cluster-name: << parameters.cluster-name >>
      install-kubectl: true
  - kubernetes/create-or-update-resource:
      get-rollout-status: true
      resource-file-path: project5-app-deployment.yml
      resource-name: deployment/sunilapp

    - kubernetes/create-or-update-resource:
        resource-file-path: "deployment/project5-lb.yml"
        resource-name: deployment/sunilapp        
  ```
  
## Update the container image using `aws-eks/update-container-image`
  ```
  aws-eks/update-container-image:
    cluster-name: sunilapp
    container-image-updates: sunilapp=mrsunilmehta/project5
    requires:
        - create-deployment
    resource-name: deployment/sunilapp
  ```

## Testing the cluster steps
  ```
  - kubernetes/install
  - aws-eks/update-kubeconfig-with-authenticator:
      cluster-name: << parameters.cluster-name >>
  - run:
      name: Test cluster
      command: |
        kubectl get svc
        kubectl get nodes
        kubectl get deployment
  ```

## Usage

Run the Pipeline by pushing a new commit to the GitHub repository or manually in the project’s GUI in CircleCI

## Screenshots

* **Circleci project.jpg**
* **Circleci Env Variables.jpg**
* **Circle CI successful execution of pipeline.jpg**
* **Lint result.jpg**
* **Dockerhub.jpg**
* **Successful push of image.jpg**
* **Successful creation of eks cluster.jpg**
* **Updated k8.jpg**
* **Updated k8 with load balancer.jpg**
* **Circle CI successful execution of pipeline with deletion.jpg**
* **Successful execution of delete cluster job**


 ## References
 - https://circleci.com/developer/orbs/orb/circleci/kubernetes
 - https://circleci.com/developer/orbs/orb/circleci/aws-eks


<!-- CONTACT -->
## Contact

Sunil Mehta - [@SunilMehta](https://www.linkedin.com/in/sunilmehta/)

<!-- Acknowledgement -->
## Acknowledgements

Special thanks to Udacity and NatWest for providing this opportunity.