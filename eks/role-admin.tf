resource "aws_iam_role" "eks-admin" {
  name = "eks-admin"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "eks-admin" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-admin.name
}


resource "aws_iam_instance_profile" "eks-admin" {
  name = "eks-admin"
  role = aws_iam_role.eks-admin.name
}