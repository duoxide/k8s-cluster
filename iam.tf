resource "aws_iam_role" "ec2_master_role" {
  name               = "master-role"
  assume_role_policy = file("trusted-entity.json")
}

resource "aws_iam_role" "ec2_worker_role" {
  name               = "worker-role"
  assume_role_policy = file("trusted-entity.json")
}

resource "aws_iam_policy" "master_policy" {
  name        = "master-policy"
  description = "Master policy"
  policy      = file("master-policy.json")
}

resource "aws_iam_policy" "worker_policy" {
  name        = "worker-policy"
  description = "Worker policy"
  policy      = file("worker-policy.json")
}

resource "aws_iam_policy_attachment" "master-attach" {
  name       = "master-attachment"
  roles      = ["${aws_iam_role.ec2_master_role.name}"]
  policy_arn = aws_iam_policy.master_policy.arn
}

resource "aws_iam_policy_attachment" "worker-attach" {
  name       = "worker-attachment"
  roles      = ["${aws_iam_role.ec2_worker_role.name}"]
  policy_arn = aws_iam_policy.worker_policy.arn
}

resource "aws_iam_instance_profile" "master_profile" {
  name  = "master-profile"
  role = aws_iam_role.ec2_master_role.name
}

resource "aws_iam_instance_profile" "worker_profile" {
  name  = "worker-profile"
  role = aws_iam_role.ec2_worker_role.name
}