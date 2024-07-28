#!/bin/bash

# Start Zookeeper
nohup zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties > /var/log/zookeeper.log 2>&1 &
echo "Zookeeper started."

# Start Kafka
nohup kafka-server-start.sh /opt/kafka/config/server.properties > /var/log/kafka.log 2>&1 &
echo "Kafka started."

# Start Spark Master
nohup spark-class org.apache.spark.deploy.master.Master --host `hostname` > /var/log/spark-master.log 2>&1 &
echo "Spark Master started."
sleep 5  # Wait for master to start

# Start Spark Worker
nohup spark-class org.apache.spark.deploy.worker.Worker spark://`hostname`:7077 > /var/log/spark-worker.log 2>&1 &
echo "Spark Worker started."

# (Optional) Start Elasticsearch if running locally
nohup elasticsearch > /var/log/elasticsearch.log 2>&1 &
echo "Elasticsearch started."

# Keep the script running
tail -f /dev/null
