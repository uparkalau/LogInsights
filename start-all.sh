#!/bin/bash
# Start Kafka
nohup zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties > /dev/null 2>&1 &
nohup kafka-server-start.sh /opt/kafka/config/server.properties > /dev/null 2>&1 &

# Start Spark (in standalone mode)
nohup spark-class org.apache.spark.deploy.master.Master --host `hostname` > /dev/null 2>&1 &
sleep 5  # Wait for master to start
nohup spark-class org.apache.spark.deploy.worker.Worker spark://`hostname`:7077 > /dev/null 2>&1 &

# (Optional) Start Elasticsearch if running locally
# nohup elasticsearch > /dev/null 2>&1 &
