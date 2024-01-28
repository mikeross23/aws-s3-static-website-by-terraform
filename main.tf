# Create s3 bucket

resource "aws_s3_bucket" "mywebsite" {
  bucket = var.bucketname
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.mywebsite.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.mywebsite.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.mywebsite.id
  acl    = "public-read"
}
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.mywebsite.id
  key          = "index.html"
  source       = "index.html"
  acl          = "public-read"
  content_type = "text/html"
}
resource "aws_s3_object" "contacts" {
  bucket       = aws_s3_bucket.mywebsite.id
  key          = "contacts.html"
  source       = "contacts.html"
  acl          = "public-read"
  content_type = "text/html"
}
resource "aws_s3_object" "about" {
  bucket       = aws_s3_bucket.mywebsite.id
  key          = "about.html"
  source       = "about.html"
  acl          = "public-read"
  content_type = "text/html"
}

# resource "null_resource" "upload_files1" {
#   depends_on = [aws_s3_bucket.mywebsite]
#   provisioner "local-exec" {
#     command = <<EOT
# aws s3 cp --recursive --content-type "text/css" /Users/maximefanin/aws+terraform_static_website/css s3://${aws_s3_bucket.mywebsite.bucket}/
# EOT
#   }
# }
# resource "null_resource" "upload_files2" {
#   depends_on = [aws_s3_bucket.mywebsite]
#   provisioner "local-exec" {
#     command = <<EOT
# aws s3 cp --recursive --content-type "image/png+jpg" /Users/maximefanin/aws+terraform_static_website/img s3://${aws_s3_bucket.mywebsite.bucket}/
# EOT
#   }
# }

# Upload CSS files
resource "aws_s3_object" "css_files" {
  for_each     = fileset("${path.module}/css", "**/*.css")
  bucket       = aws_s3_bucket.mywebsite.id
  source       = "${path.module}/css/${each.value}"
  key          = each.value
  acl          = "public-read"
  content_type = "text/css"
}

# Upload PNG files
resource "aws_s3_object" "png_files" {
  for_each     = fileset("${path.module}/img", "**/*.png")
  bucket       = aws_s3_bucket.mywebsite.id
  source       = "${path.module}/img/${each.value}"
  key          = each.value
  acl          = "public-read"
  content_type = "image/png"
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.mywebsite.id
  index_document {
    suffix = "index.html"
  }
  depends_on = [aws_s3_bucket_acl.example]
}
