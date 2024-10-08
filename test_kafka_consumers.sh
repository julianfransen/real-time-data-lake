#!/bin/bash

BASEDIR="./real-time-data-lake/kafka_2.13-3.8.0/"

# Open the first terminal for topic1
gnome-terminal -- bash -c "$BASEDIR/bin/kafka-console-producer.sh --topic crypto-exchange-rates --bootstrap-server localhost:9092; exec bash"

# Open the second terminal for topic2
gnome-terminal -- bash -c "$BASEDIR/bin/kafka-console-producer.sh --topic crypto-order-book --bootstrap-server localhost:9092; exec bash"

# Open the third terminal for topic3
gnome-terminal -- bash -c "$BASEDIR/bin/kafka-console-producer.sh --topic crypto-trades --bootstrap-server localhost:9092; exec bash"

# Open the fourth terminal for topic4
gnome-terminal -- bash -c "$BASEDIR/bin/kafka-console-producer.sh --topic ohlcv-data --bootstrap-server localhost:9092; exec bash"
