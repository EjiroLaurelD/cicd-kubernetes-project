#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage("Create an EKS Cluster") {
            steps {
                script {
                    dir('terraform') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }  
        stage("Deploy to EKS") {
            steps {
                script {
                    dir('kubernetes') {
                        sh "aws eks --region us-east-1 update-kubeconfig --name Eks-cluster"
                        sh "kubectl apply -f sock-shop.yaml"
                        sh "kubectl apply -f porfolio.yaml"
                        sh "kubectl apply -f manifests-monitoring"
                        sh "sleep 120s"
                        sh "kubectl get deployment -n sockshop"
                        sh "kubectl get deployment -n portfolio"
                        sh "sleep 60s"
                    }
                }
            }
        }
    }
}
 




