resource "aws_subnet" "public" {

  ## Create one subnet per az listed in the vars
  count                   = length(var.az)
  vpc_id                  = aws_vpc.main.id

  ## Subnets should be consecutive starting
  cidr_block              = cidrsubnet("10.0.0.0/16", 4, count.index)

  ## Public subnets get public IPs
  map_public_ip_on_launch = true

  ## Put each subnet in the region/az based on vars
  availability_zone       = "${var.AWS_REGION}${element(var.az[count.index], 0)}"

  tags = {
    "Name" = "public-${var.AWS_REGION}${element(var.az[count.index], 0)}"
  }
}

resource "aws_subnet" "private" {
  
  ## Create one subnet per az listed in the vars
  count                   = length(var.az)
  vpc_id                  = aws_vpc.main.id

  ## Subnets should be consecutive starting right after public subnets
  cidr_block              = cidrsubnet("10.0.0.0/16", 4, count.index + length(var.az))

  ## Private subnets don't get public IPs
  map_public_ip_on_launch = false

  ## Put each subnet in the region/az based on vars
  availability_zone       = "${var.AWS_REGION}${element(var.az[count.index], 0)}"

  tags = {
    "Name" = "private-${var.AWS_REGION}${element(var.az[count.index], 0)}"
  }
}
