#!/bin/bash

pkill -f 'zookeeper-server-start'
pkill -f 'kafka-server-start'
pkill -f 'airflow scheduler'  # Kills all running Airflow Scheduler processes
pkill -f 'airflow webserver'  # Kills all running Airflow Webserver processes

echo "Killed kafka, zookeeper, airflow."
