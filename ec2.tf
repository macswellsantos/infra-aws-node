resource "aws_instance" "node_server" {
  ami                    = "ami-06f1fc9ae5ae7f31e" #Amazon Linux 2023 (kernel-6.1)
  instance_type          = "t3.micro"
  key_name               = "chave-node-prod"
  vpc_security_group_ids = [aws_security_group.node_sg.id]
  iam_instance_profile   = "ECR-EC2-Role"
  user_data              =  file("script.sh")

  tags = {
    Name        = "node-server"
    Provisioned = "Terraform"
  }
}

resource "aws_security_group" "node_sg" {
  name   = "node-sg"
  vpc_id = "vpc-0e9d0b88229d81efc"

  tags = {
    Name        = "node-sg"
    Provisioned = "Terraform"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_ssm_parameter" "node_server_public_ip" {
  name  = "/meu-projeto/prod/ec2/node-server/public_ip"
  type  = "String"

  value = aws_instance.node_server.public_ip

  depends_on = [aws_instance.node_server]
}