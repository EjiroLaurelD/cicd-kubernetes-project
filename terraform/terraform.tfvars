name = "dev-env"
region = "us-east-1"
cidr_block = "10.0.0.0/16"
public_cidr_block = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
private_cidr_block = [ "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24" ]
availability_zones = [ "us-east-1a", "us-east-1b", "us-east-1c" ]
num_nat_gateways = 1
cluster_version= 1.25
