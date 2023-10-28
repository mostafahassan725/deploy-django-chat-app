#Project Overview
This project is a Django chat app deployed on AWS EKS Kubernetes service. It uses Tailwind CSS and Channels to provide a modern and interactive user experience. The project also uses Terraform, Terragrunt, and Ansible to provision and manage the AWS infrastructure and Jenkins pipeline.

##Folder Structure
├── LICENSE
├── README.md
├── ansible
│   ├── hosts
│   ├── jenkins-playbook.yaml
│   └── requirements.txt
├── djangoChatApp
│   ├── Dockerfile.asgi
│   ├── Dockerfile.web
│   ├── kubernetes
│   ├── djangoChatApp
│   │   ├── __init__.py
│   │   ├── asgi.py
│   │   ├── settings.py
│   │   ├── urls.py
│   │   └── wsgi.py
│   ├── docker-compose.yaml
│   ├── homeApp
│   │   ├── __init__.py
│   │   ├── admin.py
│   │   ├── apps.py
│   │   ├── consumers.py
│   │   ├── migrations
│   │   ├── models.py
│   │   ├── routing.py
│   │   ├── tests.py
│   │   ├── urls.py
│   │   └── views.py
│   ├── manage.py
│   ├── package-lock.json
│   ├── package.json
│   ├── requirements.txt
│   ├── scripts
│   │   └── entrypoint.sh
│   ├── static
│   │   └── src
│   ├── tailwind.config.js
│   └── templates
│       ├── chat.html
│       └── home.html
├── jenkins
│   └── JenkinsFile
└── terraform
    └── dev
        ├── data-stores
        ├── global
        ├── mgmt
        ├── monitor
        ├── services
        ├── tags.hcl
        ├── terragrunt.hcl
        └── vpc

##Deployment Steps
Provision the AWS infrastructure using Terraform:
```cd terraform/dev
terragrunt run-all plan
terragrunt run-all apply```
##Configure the Jenkins server using Ansible and run the pipeline in which the Django app Docker image is built and pushed to Docker Hub and ECR:
```cd ansible
ansible-playbook -i hosts jenkins-playbook.yml```
##Deploy the Django chat app to EKS Kubernetes service:
```cd djangoChatApp/kubernetes
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml```
##Usage
Once the Django chat app is deployed to EKS Kubernetes service, you can access it at the following URL:

http://<service-load-balancer-dns-name>/
Requirements
Python 3.7+
Terraform 1.1+
Ansible 2.9+
Docker 19.03+
Kubernetes 1.18+
License
This project is licensed under the MIT License.