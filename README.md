# cicd-kubernetes-project

- I built the environment needed for this project on AWS using Terraform.
- I explored learning Jenkins and Github-actions as my tool for continuous integration and deployment but i used jenkins for this project.

- I depoyed my portoflio app, sock-shock app, and set up monitoring and alerting  using prometheus and grafana with cloud watch as my logging tool. I also attempted to set up Honeycomb.io for traces, everything needed for observability(metrics, logs and trace).

- I got a certificate from letsencrypt using Kubernetes certificate manager and used nginx controller to route traffic from the network load balancer created in the cluster to route 53
-
- Below are url of the apps deployed  

portfolio.ejirolaureld.me
sockshop.ejirolaureld.me
grafana.ejirolaureld.me
prometheus.ejirolaureld.me

![sock](./sockshop.png)  
![sock](./portfolio.png)
![sock](./grafana.png)  
![sock](./prometheus.png)  
