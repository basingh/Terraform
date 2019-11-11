provider "aws"{
    region = "ap-southeast-2"
}
# Create new security group
resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

    ingress{
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Create a new AWS Instance
resource "aws_instance" "balTerraformEx" {
  ami           = "ami-08a74056dfd30c986"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
                #!/bin/bash
                echo "Hello World" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF
                
  tags = {
      Name = "balTerraformEx"
  }
}