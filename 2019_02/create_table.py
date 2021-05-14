import psycopg2
import os

pw = os.environ.get('postgres')

conn = psycopg2.connect("host=localhost dbname=postgres user=postgres password=" + pw)

cur = conn.cursor()
cur.execute("""
    CREATE TABLE preppin_data_2019_02(
    city text,
    metric text,
    measure text,
    value integer,
    "date" text
)
""")

with open('Week Two Input.csv', 'r') as f:
    next(f)  # Skip the header row.
    cur.copy_from(f, 'preppin_data_2019_02', sep=',')

conn.commit()
