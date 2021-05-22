import psycopg2
import os

pw = os.environ.get('postgres')

conn = psycopg2.connect("host=localhost dbname=postgres user=postgres password=" + pw)
cur = conn.cursor()

def read_file(file_name, table_name, delimiter):
    with open(file_name, 'r') as f:
        next(f)  # Skip the header row.
        cur.copy_from(f, table_name, sep=delimiter)

cur.execute("""
    CREATE TABLE preppin_data_2021_02(
    bike_type text,
    store text,
    order_date date,
    qty integer,
    value_per_bike integer,
    shipping_date date,
    model text
)
""")

read_file('Bike Model Sales.csv', 'preppin_data_2021_02', ',')

conn.commit()
conn.close()