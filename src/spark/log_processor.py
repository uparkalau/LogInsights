from pyspark.sql import SparkSession
from pyspark.sql.functions import col, from_json

def process_logs():
    spark = SparkSession.builder \
        .appName("LogProcessor") \
        .config("spark.jars.packages", "org.apache.spark:spark-sql-kafka-0-10_2.12:3.5.1") \
        .getOrCreate()

    df = spark \
        .readStream \
        .format("kafka") \
        .option("kafka.bootstrap.servers", "kafka:9092") \
        .option("subscribe", "log_topic") \
        .load()

    schema = "timestamp STRING, log_level STRING, log_type STRING, message STRING, user_agent STRING"

    logs = df.selectExpr("CAST(value AS STRING)") \
        .select(from_json(col("value"), schema).alias("log")) \
        .select("log.*")

    logs.writeStream \
        .format("parquet") \
        .option("path", "data/processed_logs/") \
        .option("checkpointLocation", "data/checkpoints/") \
        .start() \
        .awaitTermination()

if __name__ == "__main__":
    process_logs()
