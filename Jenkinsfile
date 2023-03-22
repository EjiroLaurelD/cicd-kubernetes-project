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
                    dir('./terraform') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }  
        stage("Deploy to EKS") {
            steps {
                script {
                    dir('deploy') {
                        sh "aws eks --region us-east-1 update-kubeconfig --name eks-cluster-dev-env-us-east-1"
                        sh "kubectl apply -f complete-demo.yaml"
                        sh "kubectl apply -f ./portfolio-manifest/"
                        sh " kubectl delete -f ./manifest-monitoring/"
                        #sh "kubectl apply -f ./manifests-monitoring/$(ls *-prometheus-*.yaml | awk ' { print " -f " $1 } ')" jenkins groovy language couldn't read
                        #sh "kubectl apply -f ./manifests-monitoring/$(ls *-grafana-*.yaml | awk ' { print " -f " $1 }'  | grep -v grafana-import)" grovy language could read
                        sh "kubectl apply -f ./manifest-monitoring/
                        sh "kubectl apply -f sockshop-ingress.yaml"
                        
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
 




