resource "aws_iam_role" "lambda" {
  name = "${var.service_name}-lambda"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = [
            "lambda.amazonaws.com",
            "edgelambda.amazonaws.com"
          ]
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}
