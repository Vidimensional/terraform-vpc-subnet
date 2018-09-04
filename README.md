# terraform-vpc-subnet

Terraform module for deploying VPC subnets.

## Example usage:
```
resource "aws_vpc" "vpc" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc.id}"
}

module "subnet-public" {
  source = "git@github.com:Vidimensional/terraform-vpc-subnet.git"

  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "10.1.1.0/24"
  availability_zone = "eu-west-1a"
  public            = "true"
  gateway_id        = "${aws_internet_gateway.gw.id}"
  tags              = { 
    Project = "example"
    Env     = "test"
  }
}
```

## Argument reference
* **vpc_id**: (Required) The id of the VPC that the subnet belongs to.
* **cidr_block**: (Required) The cidr block of the desired subnet.
* **availability_zone**: (Required) The availability zone where the subnet must reside.
* **public**: (Optional, default "false") Defines if the subnet is going to be visible from Internet,
* **gateway_id**: (Required only if _public_ is "true") The Internet Gateway on which it is going to route traffic to the Internet.
* **tags**: (Optional) Object with two fields: Project and Env. It creates the tags for the elements.
