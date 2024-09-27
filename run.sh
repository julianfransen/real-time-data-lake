#!/bin/bash

BASEDIR="./real-time-data-lake/kafka_2.13-3.8.0/"

# Start Zookeeper server in the background
echo "Starting Zookeeper..."
"$BASEDIR/bin/zookeeper-server-start.sh" "$BASEDIR/config/zookeeper.properties" > "$BASEDIR/logs/zookeeper_terminal.log" 2>&1 &

# Give Zookeeper a few seconds to start before launching Kafka
sleep 5

# Start Kafka broker in the background
echo "Starting Kafka broker..."
"$BASEDIR/bin/kafka-server-start.sh" "$BASEDIR/config/server.properties" > "$BASEDIR/logs/kafka_terminal.log" 2>&1 &

# Notify the user
echo "Zookeeper and Kafka broker services are started in the background."
echo "Logs can be found in zookeeper.log and kafka.log"


# Give Kafka some time to initialize
sleep 5

# Start the Airflow scheduler in the background
echo "Starting Airflow scheduler..."
airflow scheduler > "./airflow/logs/airflow_scheduler.log" 2>&1 &

# Start the Airflow webserver in the background
echo "Starting Airflow webserver..."
airflow webserver &

# Wait for the webserver to start
sleep 10

# Open the Airflow UI in the default web browser
echo "Opening Airflow UI in the browser..."
if command -v xdg-open > /dev/null; then
  xdg-open http://localhost:8080/home
elif command -v open > /dev/null; then
  open http://localhost:8080/home  # For macOS
else
  echo "Please manually open the following URL in your browser: http://localhost:8080/home"
fi

echo "Zookeeper, Kafka, and Airflow services are running."

#To kill:
#pkill -f 'zookeeper-server-start'
#pkill -f 'kafka-server-start'
#pkill -f 'airflow scheduler'  # Kills all running Airflow Scheduler processes
#pkill -f 'airflow webserver'  # Kills all running Airflow Webserver processes
