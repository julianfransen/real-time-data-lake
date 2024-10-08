# Airflow DAG (Running All Producers Every 5 Minutes):

from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime, timedelta
import sys
import os

dag_directory = os.path.dirname(os.path.abspath(__file__))  # This gets the directory of the current DAG file
src_directory = os.path.abspath(os.path.join(dag_directory, '..'))  # Go one level up to the src/ directory
sys.path.insert(0, src_directory)  # Add src/ directory to Python path

# Define your DAG with the desired schedule (default 5 minutes)
default_args = {
    'owner': 'jf',
    'depends_on_past': False,
    'start_date': datetime(2024, 10, 2), # Adjust the start date
    'retries': 1,
    'retry_delay': timedelta(minutes=1),
}

dag = DAG(
    'crypto_data_pipeline_dag',
    default_args=default_args,
    description='A DAG to fetch crypto data (exchange rate, trades, OHLCV, order book) from CoinAPI',

    #schedule_interval='35-45 16 * * *',  # CRON for running every minute from 16:25 to 16:39
    catchup=False,
    # Run every 5 minutes
    schedule_interval='*/5 * * * *',  # Every 5 minutes
    
    # Uncomment the below line to run every 1 minute
    #schedule_interval='* * * * *',  # Every 1 minute
    
)

# Function to call the exchange rate producer script
def run_fetch_exchange_rate():
    import exchange_rate_producer  # Assuming your script is saved as exchange_rate_producer.py
    exchange_rate_producer.fetch_exchange_rate()

# Function to call the trades producer script
def run_fetch_trades():
    import trades_producer  # Assuming your script is saved as trades_producer.py
    trades_producer.fetch_trades()

# Function to call the OHLCV producer script
def run_fetch_ohlcv():
    import ohlcv_producer  # Assuming your script is saved as ohlcv_producer.py
    ohlcv_producer.fetch_ohlcv_data()

# Function to call the order book producer script
def run_fetch_order_book():
    import order_book_producer  # Assuming your script is saved as order_book_producer.py
    order_book_producer.fetch_order_book_data()

# Task definitions
fetch_exchange_rate_task = PythonOperator(
    task_id='fetch_exchange_rate',
    python_callable=run_fetch_exchange_rate,
    dag=dag,
)

fetch_trades_task = PythonOperator(
    task_id='fetch_trades',
    python_callable=run_fetch_trades,
    dag=dag,
)

fetch_ohlcv_task = PythonOperator(
    task_id='fetch_ohlcv',
    python_callable=run_fetch_ohlcv,
    dag=dag,
)

fetch_order_book_task = PythonOperator(
    task_id='fetch_order_book',
    python_callable=run_fetch_order_book,
    dag=dag,
)

# Define task dependencies (optional)
# You can have them run in parallel or define the order of execution
# the tasks are set to run in sequence (>>), but you can modify this if you want them to run in parallel (by removing the >> dependencies).
fetch_exchange_rate_task >> fetch_trades_task >> fetch_ohlcv_task >> fetch_order_book_task
