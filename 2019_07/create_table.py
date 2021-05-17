import psycopg2
import os

pw = os.environ.get('postgres')

conn = psycopg2.connect("host=localhost dbname=postgres user=postgres password=" + pw)
cur = conn.cursor()

def read_file(file_name, table_name):
    with open(file_name, 'r') as f:
        next(f)  # Skip the header row.
        cur.copy_from(f, table_name, sep=',')

cur.execute("""
    CREATE TABLE preppin_data_2019_07_departure(
    ship_id text,
    departure_date date,
    max_weight integer,
    max_volume integer
)
""")

cur.execute("""
    CREATE TABLE preppin_data_2019_07_allocation(
    sales_person text,
    departure_id text,
    date_logged date,
    product_type text,
    weight_allocated integer,
    volume_allocated integer
)
""")

read_file('departure.csv', 'preppin_data_2019_07_departure')
read_file('allocation.csv', 'preppin_data_2019_07_allocation')

conn.commit()
conn.close()