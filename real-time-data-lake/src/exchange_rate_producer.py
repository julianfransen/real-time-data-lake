import requests
from confluent_kafka import Producer
import json

headers = {'X-CoinAPI-Key': '8e64a7e8-441f-44ee-95a7-a80d00d494f1'}

# Kafka producer setup
producer = Producer({'bootstrap.servers': 'localhost:9092'})

def fetch_exchange_rate():
    response = requests.get('https://rest.coinapi.io/v1/exchangerate/BTC/USD', headers=headers)
    if response.status_code == 200:
        data = response.json()
        producer.produce('crypto-exchange-rates', value=json.dumps(data))
        producer.flush()
    else:
        print(f"Error: {response.status_code}, {response.text}")

if __name__ == '__main__':
    fetch_exchange_rate()
