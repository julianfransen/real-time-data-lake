# real-time-data-lake
This project builds a real-time data pipeline that ingests, processes, and stores real-time cryptocurrency data. It integrates Kafka for streaming, Spark for processing, and AWS S3 for storage. Data quality is ensured with Great Expectations.

### Features:
- Real-time data ingestion using Apache Kafka.
- Stream processing with Apache Spark.
- Automated ETL pipeline with Apache Airflow.
- Data quality validation with Great Expectations.

### Installation:
1. Install Apache Kafka: [Kafka Quickstart](https://kafka.apache.org/quickstart).
2. Install Apache Spark: [Spark Installation Guide](https://spark.apache.org/docs/latest/).
3. Set up AWS S3 or Google Cloud Storage.
4. Install Python dependencies: 
```bash
pip install -r requirements.txt
