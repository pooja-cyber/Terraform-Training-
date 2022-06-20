//EC2setup
resource "aws_instance" "ec2-web" {
  ami           = "ami-079b5e5b3971bd10d"
  instance_type = "t2.micro"

  tags = {
    Name = "tf-ec2"
  }
}
//

//SecurityGroup with webserver
resource "aws_security_group" "instance" {
  name = "terraform-sg"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "example" {
  ami                    = "ami-068257025f72f470d"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  user_data              = <<EOF
#!/bin/bash
apt-get update
apt-get install -y apache2
systemctl start apache2
systemctl enable apache2
echo "<h1> Hello bosch</h1>" | sudo tee /var/www/html/index.html
EOF
  tags = {
    Name = "terraform-example"
  }
}

//CustomVPC


resource "aws_security_group" "sg1" {
name = "terraform-sg1"

ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port = 443
to_port = 443
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port = 9090
to_port = 9090
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}

}
