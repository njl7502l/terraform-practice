resource "aws_s3_bucket" "html_bucket" {
  bucket        = "${var.common.app_name}-${var.common.env}-html-bucket"
  force_destroy = true
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.html_bucket.id
  key    = "index.html"
  source = "../../modules/application/s3/index.html"
}
