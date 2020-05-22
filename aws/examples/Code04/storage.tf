resource "aws_s3_bucket" "application-bins" {
  bucket = "sdkjhfynmcb-2343-xu"
  acl = "public-read"
}

output "bucket_url" {
  value = "${aws_s3_bucket.application-bins.bucket_domain_name}"
}