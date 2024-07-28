# Use a base image with Python and Java (for Spark)
FROM openjdk:11-jre-slim

# Set environment variables
ENV PYSPARK_PYTHON=python3
ENV SPARK_HOME=/opt/spark

# Install Python and pip
RUN apt-get update && apt-get install -y python3 python3-pip

# Install Python dependencies
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Install Kafka and Elasticsearch libraries (adjust versions if needed)
RUN pip3 install kafka-python elasticsearch

# Download and extract Spark (adjust version as needed)
RUN apt-get update && apt-get install -y wget
RUN wget -q https://dlcdn.apache.org/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz \
    && tar -xzf spark-3.5.1-bin-hadoop3.tgz -C /opt \
    && rm spark-3.5.1-bin-hadoop3.tgz \
    && ln -s /opt/spark-3.5.1-bin-hadoop3 /opt/spark

# Make Spark available
ENV PATH=$PATH:$SPARK_HOME/bin

# Set the working directory
WORKDIR /app

# Copy your project files
COPY . .

# Copy the start-all.sh script
COPY start-all.sh /usr/local/bin/start-all.sh

# Make the script executable
RUN chmod +x /usr/local/bin/start-all.sh

# Expose ports if needed
# Kafka
EXPOSE 9092
# Spark UI
EXPOSE 8080
# Elasticsearch (if running locally)
EXPOSE 9200  
# Jupyter Notebook
EXPOSE 8888

# Start Kafka, Spark, Elasticsearch, and Jupyter Notebook
CMD ["/bin/bash", "-c", "start-all.sh && jupyter notebook --ip=0.0.0.0 --no-browser --allow-root --NotebookApp.token=''"]
