FROM openjdk:11-jre-slim

ENV PYSPARK_PYTHON=python3
ENV SPARK_HOME=/opt/spark

RUN apt-get update && apt-get install -y python3 python3-pip

COPY requirements.txt .
RUN pip3 install -r requirements.txt

RUN pip3 install kafka-python elasticsearch

RUN apt-get update && apt-get install -y wget
RUN wget -q https://dlcdn.apache.org/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz \
    && tar -xzf spark-3.5.1-bin-hadoop3.tgz -C /opt \
    && rm spark-3.5.1-bin-hadoop3.tgz \
    && ln -s /opt/spark-3.5.1-bin-hadoop3 /opt/spark

ENV PATH=$PATH:$SPARK_HOME/bin

WORKDIR /app

COPY . .

#Kafka
EXPOSE 9092
#Spark UI
EXPOSE 8080
#Elasticsearch (if running locally)
EXPOSE 9200  

# Start Kafka, Spark, and Elasticsearch (if running locally)
CMD ["/bin/bash", "-c", "start-all.sh && tail -f /dev/null"]
