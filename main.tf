# Terraform file (main.tf) to create an S3 bucket 
resource "aws_s3_bucket" "athena_demo_bucket" {
  bucket = "athena-demo-bucket-${random_id.bucket_id.hex}"
}

resource "random_id" "bucket_id" {
  byte_length = 8
}

resource "aws_s3_bucket_policy" "athena_demo_bucket_policy" {
  bucket = aws_s3_bucket.athena_demo_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          "AWS" = "arn:aws:iam::396845391024:user/williambarstad"
        }
        Action   = "s3:GetObject"
        Resource = "arn:aws:s3:::${aws_s3_bucket.athena_demo_bucket.id}/*"
      }
    ]
  })
}

resource "aws_s3_object" "data_files" {
  for_each   = fileset("/DATA", "*")
  bucket     = aws_s3_bucket.athena_demo_bucket.id
  key        = each.value
  source     = "${path.module}/DATA/${each.value}"
}

resource "aws_glue_catalog_database" "athena_database" {
  name = "athena_demo_db"
}

resource "aws_glue_catalog_table" "athena_table" {
  name          = "drivers"
  database_name = aws_glue_catalog_database.athena_database.name

  table_type = "EXTERNAL_TABLE"
  parameters = {
    "classification" = "csv"
  }

  storage_descriptor {
    location      = "s3://${aws_s3_bucket.athena_demo_bucket.bucket}/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      serialization_library = "org.apache.hadoop.hive.serde2.OpenCSVSerde"
    }
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.athena_demo_bucket.bucket
}

output "database_name" {
  value = aws_glue_catalog_database.athena_database.name
}

output "table_name" {
  value = aws_glue_catalog_table.athena_table.name
}