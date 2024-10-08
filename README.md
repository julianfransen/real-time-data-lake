# real-time-data-lake
This project builds a real-time data pipeline that ingests, processes, and stores real-time cryptocurrency data. It integrates Kafka for streaming, Spark for processing, and AWS S3 for storage. Data quality is ensured with Great Expectations.

### Features:
- Real-time data ingestion using Apache Kafka.
- Stream processing with Apache Spark.
- Automated ETL pipeline with Apache Airflow.
- Data quality validation with Great Expectations.

### Installation:
Run Dockerimage
# Run the container interactively:
docker run --env-file .env -it --rm real-time-data-lake

!!!! make sure you manually open the URL when this appears in terminal:
 "Airflow UI is available at: http://localhost:8080/home"



# Run in detached mode (background):
docker run -d --env-file .env --name my-container real-time-data-lake

# Stop the container (if needed):
docker stop my-container
