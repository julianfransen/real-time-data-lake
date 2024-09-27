#!/bin/bash

BASEDIR="./real-time-data-lake/kafka_2.13-3.8.0/"

# Define your topics and bootstrap server
TOPICS=("my-data-stream" "crypto-exchange-rates" "crypto-rates" "ohlcv-data" "crypto-order-book")
BOOTSTRAP_SERVER="localhost:9092"

# Iterate over topics and open each in a new terminal tab
for TOPIC in "${TOPICS[@]}"; do
  gnome-terminal --tab --title="$TOPIC" -- bash -c ""$BASEDIR/bin/kafka-console-consumer.sh" --topic $TOPIC --from-beginning --bootstrap-server $BOOTSTRAP_SERVER; exec bash"
done

