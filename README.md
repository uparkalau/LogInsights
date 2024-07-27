# LogInsights: A Scalable Log Analytics Pipeline

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

LogInsights provide important data from vast amounts of log data. This data engineering project use Kafka, Spark, and Elasticsearch on AWS to build a robust and efficient log analytics pipeline.

## Features

- **Scalable Ingestion:**  Efficiently handles high-volume log streams in real-time using Kafka:

```python
from kafka import KafkaProducer
producer.send('log_topic', value=log_message.encode('utf-8'))
```

- **Distributed Processing:** Transforms and aggregates log data at scale with Spark:

```python
from pyspark.sql import SparkSession
from pyspark.sql.functions import *
error_counts = df.filter(col("level") == "ERROR").groupBy("type").count()
```

- **Powerful Search and Analysis:** Quickly index and search log data in Elasticsearch:

```python
from elasticsearch import Elasticsearch
es.index(index='log_index', document=log_record)
```

- **AWS Integration:**  Deploys seamlessly on AWS use managed services for scalability and reliability.
- **Data Simulation:** Generates realistic log data for testing and development purposes.
- **Monitoring and Alerting:** Includes basic monitoring and alerting to proactively address pipeline issues.
- **Dockerized:** Packaged in a Docker container for easy local setup and deployment.

## Getting Started

1. **Prerequisites:** 
   - Docker: [Install Docker](https://docs.docker.com/get-docker/)
   - AWS Account: [Create an AWS account](https://aws.amazon.com/) (if deploying on AWS)

2. **Clone Repository:**
   ```bash
   git clone https://github.com/uparkalau/LogInsights.git
   ```

3. **Build Docker Image:**
   ```bash
   cd LogInsights
   docker build -t loginsights .
   ```

4. **Run with Docker:**
   ```bash
   docker run -it --rm \
     -v ${PWD}/data:/app/data \
     -p 9092:9092 -p 8080:8080 -p 9200:9200 \
     loginsights
   ```

## Future Enhancements

- Advanced Analytics (e.g., anomaly detection, machine learning)
- Customizable Dashboards (Kibana, Grafana)
- Enhanced Security (authentication, authorization)
- Automated Deployment (Terraform, AWS CloudFormation)

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

## License

This project is licensed under the MIT License.
