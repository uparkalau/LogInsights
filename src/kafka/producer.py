from kafka import KafkaProducer
import json
import time
import os

def read_logs(file_path):
    with open(file_path, 'r') as file:
        for line in file:
            yield line.strip()

def send_logs(producer, topic, file_path):
    for log in read_logs(file_path):
        producer.send(topic, value=log)
        time.sleep(0.1)  # Simulate delay

if __name__ == "__main__":
    producer = KafkaProducer(
        bootstrap_servers='kafka:9092',
        value_serializer=lambda v: json.dumps(v).encode('utf-8')
    )
    send_logs(producer, 'log_topic', 'data/raw_logs/logs.csv')
