# LogInsights: A Scalable Log Analytics Pipeline

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

LogInsights provide important data from vast amounts of log data. This data engineering project use Kafka, Spark, and Elasticsearch on AWS to build a robust and efficient log analytics pipeline.
# Step 1: Generate Log Data
- **Script**: _log_generator.py_
- **Purpose**: Simulates realistic log entries and saves them to the _data/raw_logs/_ folder. Command:
```
docker exec -it spark-container python3 /app/src/data_generation/log_generator.py
```
- Why: This step creates the initial log data that will be ingested and processed by the system.

# Step 2: Ingest Logs with Kafka Producer
- **Script**: _producer.py_ 
- Purpose: Reads the generated log files and sends them to a Kafka topic (log_topic). Command:

```
docker exec -it spark-container python3 /app/src/kafka/producer.py
```
- Why: Kafka acts as a message broker, allowing for scalable and reliable log data ingestion.

# Step 3: Process Logs with Spark
- Script: _log_processor.py_
- Purpose: Reads logs from Kafka using Spark Streaming, processes them, and writes the processed logs to the data/processed_logs/ folder in Parquet format. Command:
```
docker exec -it spark-container python3 /app/src/spark/log_processor.py
```
- Why: Spark processes the log data in real-time, enabling transformations, filtering, and aggregation of log entries.

# Step 4: Index Processed Logs with Elasticsearch
- **Script:** _indexer.py_
- Purpose: Reads processed log files from the data/processed_logs/ folder and indexes them into Elasticsearch for efficient search and analysis. Command:
```
docker exec -it spark-container python3 /app/src/elasticsearch/indexer.py
```
- Why: Elasticsearch provides powerful search and analytics capabilities, making it easy to query and analyze the processed log data.

# Step 5: Visualize Data with Jupyter Notebook
- Notebook: _data_analysis.ipynb_
- Purpose: Loads raw and processed logs, and creates visualizations to analyze log data. Command:
```
docker exec -it spark-container jupyter notebook --ip=0.0.0.0 --no-browser --allow-root --NotebookApp.token=''
```
- Why: Jupyter Notebook provides an interactive environment to explore and visualize the log data, helping to gain insights and understand patterns.

## Summary
- Generate Logs: Create initial log data.
- Ingest Logs: Send logs to Kafka for reliable ingestion.
- Process Logs: Use Spark to process and transform log data.
- Index Logs: Store processed logs in Elasticsearch for search and analysis.
- Visualize Data: Use Jupyter Notebook to explore and visualize the data.
- This workflow ensures that log data is efficiently generated, ingested, processed, indexed, and visualized, providing a comprehensive solution for log analysis.

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

## License

This project is licensed under the MIT License.
