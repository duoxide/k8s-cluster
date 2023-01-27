# Security Group Creation

resource "aws_security_group" "cluster-sg" {
  vpc_id = aws_vpc.main.id
  name   = "cluster-sg"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # self = true
  }

  ingress {
    from_port = 8443
    to_port   = 8443
    protocol  = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    self = true
  }

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    self = true
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # self = true
  }

  ingress {
    from_port = 2379
    to_port   = 2380
    protocol  = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    self = true
  }

  ingress {
    from_port = 10250
    to_port   = 10250
    protocol  = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    self = true
  }

  ingress {
    from_port = 10259
    to_port   = 10259
    protocol  = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    self = true
  }

  ingress {
    from_port = 10257
    to_port   = 10257
    protocol  = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    self = true
  }

  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 9153
    to_port   = 9153
    protocol  = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    self = true
  }

  ingress {
    from_port = 8285
    to_port   = 8285
    protocol  = "udp"
    # cidr_blocks = ["0.0.0.0/0"]
    self = true
  }

  ingress {
    from_port = 8472
    to_port   = 8472
    protocol  = "udp"
    # cidr_blocks = ["0.0.0.0/0"]
    self = true
  }

  tags = {
    Name              = "cluster-sg"
    KubernetesCluster = "true"
  }
}
