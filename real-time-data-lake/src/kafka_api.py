import requests
from kafka import KafkaProducer

producer = KafkaProducer(bootstrap_servers='localhost:9092')

response = requests.get('https://rest.coinapi.io/v1/exchangerate/BTC/USD')
producer.send('my-data-stream', value=response.content)
