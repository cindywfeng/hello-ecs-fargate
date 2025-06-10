# data "aws_vpc" "default_vpc" {
#   default = true
# }

# data "aws_route_table" "main" {
#   vpc_id = data.aws_vpc.default_vpc.id
# }

# # Internet Gateway
# resource "aws_internet_gateway" "fargate_igw" {
#   vpc_id = data.aws_vpc.default_vpc.id
# }

# # Public Subnet A
# resource "aws_subnet" "public_subnet_a" {
#   vpc_id                  = data.aws_vpc.default_vpc.id
#   cidr_block              = "172.31.200.0/24"
#   availability_zone       = "eu-west-2a"
#   map_public_ip_on_launch = true
# }

# # Public Subnet B
# resource "aws_subnet" "public_subnet_b" {
#   vpc_id                  = data.aws_vpc.default_vpc.id
#   cidr_block              = "172.31.208.0/24"
#   availability_zone       = "eu-west-2b"
#   map_public_ip_on_launch = true
# }

# # Associate subnets with route table
# resource "aws_route_table_association" "public_rt_assoc_a" {
#   subnet_id      = aws_subnet.public_subnet_a.id
#   route_table_id = data.aws_route_table.main.id

#   depends_on = [
#     aws_internet_gateway.fargate_igw
#   ]
# }

# resource "aws_route_table_association" "public_rt_assoc_b" {
#   subnet_id      = aws_subnet.public_subnet_b.id
#   route_table_id = data.aws_route_table.main.id

#   depends_on = [
#     aws_internet_gateway.fargate_igw
#   ]
# }
