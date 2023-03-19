resource "aws_vpc" "main" {         # Creating VPC here
  cidr_block       = var.cidr_block # Defining the CIDR block use 10.0.0.0/24 for demo
  instance_tenancy = "default"
  tags = merge(var.tags, {
    "Name" = "vpc-${var.name}-${data.aws_region.current.name}"
  })
}



# ---------------------------------------------------------------------------------------------------------------------
# USE A NULL RESOURCE TO INDICATE THAT THE ENVIRONMENT HAS FINISHED CREATING
# ---------------------------------------------------------------------------------------------------------------------
resource "null_resource" "environment_ready" {
  depends_on = [
    aws_internet_gateway.internet_gateway,
    aws_nat_gateway.nat_gateway,
    aws_route_table.public,
    aws_route_table.private,
  ]
}

