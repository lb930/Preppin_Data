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
    CREATE TABLE preppin_data_2019_06_company(
    month_col date,
    country text,
    category text,
    profit integer
)
""")

cur.execute("""
    CREATE TABLE preppin_data_2019_06_england(
    country text,
    category text,
    city text,
    units_sold integer
)
""")

cur.execute("""
    CREATE TABLE preppin_data_2019_06_soap(
    type text,
    cost_per_unit float,
    price_per_unit float
)
""")

read_file('Week6Input - Company Data.csv', 'preppin_data_2019_06_company')
read_file('Week6Input - England - Mar 2019.csv', 'preppin_data_2019_06_england')
read_file('Week6Input - Soap Pricing Details.csv', 'preppin_data_2019_06_soap')

conn.commit()
conn.close()