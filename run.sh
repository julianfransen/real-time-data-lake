#!/bin/bash
BASEDIR=.

ROOTDIR=/usr/local

# Start Zookeeper server in the background
echo "Starting Zookeeper..."
./kafka_2.13-3.8.0/bin/zookeeper-server-start.sh ./kafka_2.13-3.8.0/config/zookeeper.properties > ./kafka_2.13-3.8.0/logs/zookeeper_terminal.log 2>&1 &

#"$BASEDIR/kafka_2.13-3.8.0/bin/zookeeper-server-start.sh" "$BASEDIR/kafka_2.13-3.8.0/config/zookeeper.properties" > "$BASEDIR/kafka_2.13-3.8.0/logs/zookeeper_terminal.log" 2>&1 &

# Give Zookeeper a few seconds to start before launching Kafka
sleep 5

# Start Kafka broker in the background
echo "Starting Kafka broker..."
"$BASEDIR/kafka_2.13-3.8.0/bin/kafka-server-start.sh" "$BASEDIR/kafka_2.13-3.8.0/config/server.properties" > "$BASEDIR/kafka_2.13-3.8.0/logs/kafka_terminal.log" 2>&1 &

echo "Init airflow database..."
poetry run airflow db init

# Check if the user already exists, if not, create an admin user
airflow users list | grep -w "admin" > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Creating admin user..."
  airflow users create \
    --username admin \
    --firstname Admin \
    --lastname Admin \
    --role Admin \
    --email admin@example.com \
    --password admin
else
  echo "Admin user already exists."
fi

echo "Starting Airflow scheduler..."
poetry run airflow scheduler > ./airflow/logs/airflow_scheduler.log 2>&1 &
#ps aux | grep airflow scheduler 

echo "Starting Airflow webserver..." 
# Start the Airflow webserver in the background
poetry run airflow webserver  > ./airflow/logs/airflow_webserver.log #2>&1 &

# Wait for the webserver to start
sleep 10

ps aux | grep zookeeper &
echo "zookeeper is running" &&
ps aux | grep kafka & 
echo "kafka is running" &&
# Notify the user
echo "Zookeeper and Kafka broker services are started in the background."
echo "Logs can be found in zookeeper.log and kafka.log"

# Open the Airflow UI in the default web browser
# Open the Airflow UI manually
echo "Airflow UI is available at: http://localhost:8080/home"
echo "Please open the URL in your web browser."

echo "Zookeeper, Kafka, and Airflow services are running."