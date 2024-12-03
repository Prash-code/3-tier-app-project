#  creating vpc 

resource "aws_vpc" "mumbai-vpc" {
  cidr_block = "192.168.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "my-mumbai-vpc"
  }
}

# creating subnet public and private(2pub-6private)

resource "aws_subnet" "pub1" {
  vpc_id = aws_vpc.mumbai-vpc.id
  availability_zone = "ap-south-1a"
  cidr_block = "192.168.1.0/24"
  map_public_ip_on_launch = true  # for auto asign public ip for subnet
  tags = {
    Name = "public-subnet-1a"
  }
}

resource "aws_subnet" "pub2" {
  vpc_id = aws_vpc.mumbai-vpc.id
  availability_zone = "ap-south-1b"
  cidr_block = "192.168.2.0/24"
  map_public_ip_on_launch = true  # for auto asign public ip for subnet
  tags = {
    Name = "public-subnet-1b"
  }
}
resource "aws_subnet" "private1" {
  vpc_id = aws_vpc.mumbai-vpc.id
  availability_zone = "ap-south-1a"
  cidr_block = "192.168.3.0/24"
  map_public_ip_on_launch = true  # for auto asign public ip for subnet
  tags = {
    Name = "private-subnet-1a-1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id = aws_vpc.mumbai-vpc.id
  availability_zone = "ap-south-1b"
  cidr_block = "192.168.4.0/24"
  map_public_ip_on_launch = true  # for auto asign public ip for subnet
  tags = {
    Name = "public-subnet-1b-2"
  }
}

resource "aws_subnet" "private3" {
  vpc_id = aws_vpc.mumbai-vpc.id
  availability_zone = "ap-south-1a"
  cidr_block = "192.168.5.0/24"
  map_public_ip_on_launch = true  # for auto asign public ip for subnet
  tags = {
    Name = "public-subnet-1a-3"
  }
}

resource "aws_subnet" "private4" {
  vpc_id = aws_vpc.mumbai-vpc.id
  availability_zone = "ap-south-1b"
  cidr_block = "192.168.6.0/24"
  map_public_ip_on_launch = true  # for auto asign public ip for subnet
  tags = {
    Name = "public-subnet-1b-4"
  }
}

resource "aws_subnet" "private5" {
  vpc_id = aws_vpc.mumbai-vpc.id
  availability_zone = "ap-south-1a"
  cidr_block = "192.168.7.0/24"
  map_public_ip_on_launch = true  # for auto asign public ip for subnet
  tags = {
    Name = "public-subnet-1a-5"
  }
}

resource "aws_subnet" "private6" {
  vpc_id = aws_vpc.mumbai-vpc.id
  availability_zone = "ap-south-1b"
  cidr_block = "192.168.8.0/24"
  map_public_ip_on_launch = true  # for auto asign public ip for subnet
  tags = {
    Name = "public-subnet-1b-6"
  }
}

#  creating internet gateway

resource "aws_internet_gateway" "mumbai-IGW" {
    vpc_id = aws_vpc.mumbai-vpc.id
  tags = {
    Name = "my-IGW"
  }
}

#  creating public route table

resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.mumbai-vpc.id
  tags = {
    Name = "my-pub-RT"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mumbai-IGW.id
  }
}
#  attaching pub-1a subnet to public route table

resource "aws_route_table_association" "pub1a" {
  route_table_id = aws_route_table.pub-rt.id
  subnet_id = aws_subnet.pub1.id
}

#  attaching pub-2b subnet to public route table
resource "aws_route_table_association" "pub2b" {
  route_table_id = aws_route_table.pub-rt.id
  subnet_id = aws_subnet.pub2
}

#  creating elastic ip for nat gateway

resource "aws_eip" "eip" {
  
}
#  creating nat gateway
resource "aws_nat_gateway" "mynatgateway" {
  subnet_id = aws_subnet.pub1.id
  connectivity_type = "public"
  allocation_id = aws_eip.eip.id
  tags = {
    Name = "my-NAT"

  }

}
#  creating private route table 
resource "aws_route_table" "private-RT" {
    vpc_id = aws_vpc.mumbai-vpc.id
    tags = {
      Name = "mumbai-private-RT"
    }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.mynatgateway.id
  }
}
#  attaching prvt-1a-1 subnet to private route table
resource "aws_route_table_association" "private-1a-1" {
  route_table_id = aws_route_table.private-RT.id
  subnet_id = aws_subnet.private1.id
}

#  attaching prvt-1b-2 subnet to private route table

resource "aws_route_table_association" "private-1b-2" {
  route_table_id = aws_route_table.private-RT
  subnet_id = aws_subnet.private2.id
}

#  attaching prvt-1a-3 subnet to private route table
resource "aws_route_table_association" "private-1a-3" {
    route_table_id = aws_route_table.private-RT
    subnet_id = aws_subnet.private3.id
  
}

#  attaching prvt-1b-4 subnet to private route table
resource "aws_route_table_association" "private-1b-4" {
    route_table_id = aws_route_table.private-RT.id
    subnet_id = aws_subnet.private4.id
  
}
#  attaching prvt-1a-5 subnet to private route table
resource "aws_route_table_association" "private-1a-5" {
  route_table_id = aws_route_table.private-RT.id
  subnet_id = aws_subnet.private5.id
}

#  attaching prvt-1b-6 subnet to private route table

resource "aws_route_table_association" "private-1b-6" {
  route_table_id = aws_route_table.private-RT.id
  subnet_id = aws_subnet.private6.id
}