import requests
from confluent_kafka import Producer
import json

# Replace 'YOUR_API_KEY' with your actual CoinAPI key
headers = {'X-CoinAPI-Key': '8e64a7e8-441f-44ee-95a7-a80d00d494f1'}

# Kafka producer setup
producer = Producer({'bootstrap.servers': 'localhost:9092'})

def fetch_ohlcv_data():
    # Endpoint for latest OHLCV data for a specific symbol (e.g., BTC/USD)
    response = requests.get('https://rest.coinapi.io/v1/ohlcv/BITSTAMP_SPOT_BTC_USD/latest', headers=headers)
    
    # Check for a valid response
    if response.status_code == 200:
        data = response.json()
        producer.produce('ohlcv-data', value=json.dumps(data))
        producer.flush()
    else:
        print(f"Error: {response.status_code}, {response.text}")

if __name__ == '__main__':
    fetch_ohlcv_data()
