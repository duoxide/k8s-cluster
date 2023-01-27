# Master instance creation

resource "aws_instance" "master-instance" {
  count                  = var.master_instance_count
  ami                    = data.aws_ami.ubuntu_latest.id
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.main-public-1[0].id
  vpc_security_group_ids = [aws_security_group.cluster-sg.id]
  key_name               = aws_key_pair.mykeypair.key_name
  iam_instance_profile   = aws_iam_instance_profile.master_profile.name
  root_block_device {
    volume_size = 30
  }
  # user_data = file("master-install.sh")
  provisioner "local-exec" {
    command = "sleep 60; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu --private-key ~/.ssh/id_rsa -i '${self.public_ip},' ./ansible/master.yaml"
  }
  tags = {
    Name              = "master-intance-${count.index}"
    KubernetesCluster = "true"
  }
  lifecycle {
    ignore_changes = [ami]
  }
}

# Worker instance creation

resource "aws_instance" "worker-instance" {
  count                  = var.worker_instance_count
  ami                    = data.aws_ami.ubuntu_latest.id
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.main-public-1[0].id
  vpc_security_group_ids = [aws_security_group.cluster-sg.id]
  key_name               = aws_key_pair.mykeypair.key_name
  iam_instance_profile   = aws_iam_instance_profile.worker_profile.name
  root_block_device {
    volume_size = 30
  }
  depends_on = [
    aws_instance.master-instance
  ]
  # user_data = file("worker-install.sh")
  provisioner "local-exec" {
    command = "sleep 60; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu --private-key ~/.ssh/id_rsa -i '${self.public_ip},' ./ansible/worker.yaml"
  }
  tags = {
    Name              = "worker-intance-${count.index}"
    KubernetesCluster = "true"
  }
  lifecycle {
    ignore_changes = [ami]
  }
}

data "aws_caller_identity" "current" {}