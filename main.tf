
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.36.0"
    }
  }
}
#----------Provider-----------#
provider "aws"{
    region = "us-east-1"

}

variable "bucket_name" {
  description = "flugel"
  default     = "-example"
}

resource "aws_s3_bucket" "terratest_bucket" {
  bucket = "terratest${var.bucket_name}"
  versioning {
    enabled = true
  }
}

output "bucket_id" {
  value = aws_s3_bucket.terratest_bucket.id
}

 #----------Uploading multiple txt file into S3 Bucket-----------#
  resource "aws_s3_bucket_object" "S3Multipletxt" {
    bucket = aws_s3_bucket.mtsrodrigues.id
    for_each = fileset("C:\\Users\\Mateus Rodrigues\\Desktop\\flugel\\S3files","*")
    key    =  each.value
    source = "C:\\Users\\Mateus Rodrigues\\Desktop\\flugel\\S3files\\${each.value}"

    # The filemd5() function is available in Terraform 0.11.12 and later
    # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
    #etag = "${md5(file("/home/mateus/Desktop/aws-code-flugel/test1.txt"))}"
    etag = filemd5("C:\\Users\\Mateus Rodrigues\\Desktop\\flugel\\S3files\\${each.value}")
  }



 

