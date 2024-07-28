from elasticsearch import Elasticsearch, helpers
import os
import json

def index_logs(es, index_name, file_path):
    with open(file_path, 'r') as file:
        logs = json.load(file)
        actions = [
            {
                "_index": index_name,
                "_source": log
            }
            for log in logs
        ]
        helpers.bulk(es, actions)

if __name__ == "__main__":
    es = Elasticsearch(['http://localhost:9200'])
    index_logs(es, 'logs', 'data/processed_logs/logs.json')
