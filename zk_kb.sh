#!/bin/bash

BASEDIR="./kafka_2.13-3.8.0/"

poetry install --no-interaction --no-ansi --no-root

# Start Zookeeper server in the background
echo "Starting Zookeeper..."
"$BASEDIR/bin/zookeeper-server-start.sh" "$BASEDIR/config/zookeeper.properties" > "$BASEDIR/logs/zookeeper_terminal.log" 2>&1 &

# Give Zookeeper a few seconds to start before launching Kafka
sleep 5

# Start Kafka broker in the background
echo "Starting Kafka broker..."
"$BASEDIR/bin/kafka-server-start.sh" "$BASEDIR/config/server.properties" > "$BASEDIR/logs/kafka_terminal.log" 2>&1 &



# Give Kafka some time to initialize
sleep 5


ps aux | grep zookeeper


ps aux | grep kafka

# Notify the user
echo "Zookeeper and Kafka broker services are started in the background."
echo "Logs can be found in zookeeper.log and kafka.log"