provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "spark_master" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.medium"

  tags = {
    Name = "SparkMaster"
  }

  user_data = <<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install -y openjdk-11-jre-headless
wget https://dlcdn.apache.org/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz
tar -xzf spark-3.5.1-bin-hadoop3.tgz -C /opt
ln -s /opt/spark-3.5.1-bin-hadoop3 /opt/spark
EOF
}

resource "aws_instance" "spark_worker" {
  count         = 2
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.medium"

  tags = {
    Name = "SparkWorker-${count.index}"
  }

  user_data = <<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install -y openjdk-11-jre-headless
wget https://dlcdn.apache.org/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz
tar -xzf spark-3.5.1-bin-hadoop3.tgz -C /opt
ln -s /opt/spark-3.5.1-bin-hadoop3 /opt/spark
EOF
}
