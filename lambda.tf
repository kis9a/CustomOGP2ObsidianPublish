data "template_file" "preq" {
  template = file("${abspath("${path.module}/template")}/main.js")

  vars = {
    BASE_URL    = var.template.BASE_URL
    TITLE       = var.template.TITLE
    DESCRIPTION = var.template.DESCRIPTION
    IMAGE       = var.template.IMAGE
    IMAGE_TYPE  = var.template.IMAGE_TYPE
  }
}

data "archive_file" "preq" {
  type        = "zip"
  output_path = "${abspath("${path.module}/template")}/main.zip"

  source {
    content  = data.template_file.preq.rendered
    filename = "main.js"
  }
}

resource "aws_lambda_function" "preq" {
  provider         = aws.virginia
  filename         = data.archive_file.preq.output_path
  source_code_hash = data.archive_file.preq.output_base64sha256
  function_name    = var.service_name
  role             = aws_iam_role.lambda.arn
  handler          = "main.handler"
  runtime          = "nodejs14.x"
  publish          = true
}
