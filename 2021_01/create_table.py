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
    CREATE TABLE preppin_data_2021_01(
    order_id integer,
    customer_age integer,
    bike_value integer,
    existing_customer text,
    date_col date,
    bike_store text
)
""")

read_file('bike_sales.csv', 'preppin_data_2021_01', ',')

conn.commit()
conn.close()