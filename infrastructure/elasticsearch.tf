provider "aws" {
  region = "us-west-2"
}

resource "aws_elasticsearch_domain" "es_domain" {
  domain_name           = "loginsights-es"
  elasticsearch_version = "7.10"

  cluster_config {
    instance_type = "t3.small.elasticsearch"
    instance_count = 1
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
    volume_type = "gp2"
  }

  access_policies = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "es:*",
      "Resource": "arn:aws:es:us-west-2:123456789012:domain/loginsights-es/*"
    }
  ]
}
EOF

  tags = {
    Name = "LogInsightsElasticsearch"
  }
}
