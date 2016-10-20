output "id" {
    value = "${aws_s3_bucket.remote_state_bucket.id}"
}

output "arn" {
    value = "${aws_s3_bucket.remote_state_bucket.arn}"
}
