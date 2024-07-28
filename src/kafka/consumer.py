from kafka import KafkaConsumer
import json

def consume_logs(topic):
    consumer = KafkaConsumer(
        topic,
        bootstrap_servers='localhost:9092',
        auto_offset_reset='earliest',
        value_deserializer=lambda x: json.loads(x.decode('utf-8'))
    )
    for message in consumer:
        log = message.value
        print(log)  # Process log here

if __name__ == "__main__":
    consume_logs('log_topic')
