import psycopg2
import os

pw = os.environ.get('postgres')

conn = psycopg2.connect("host=localhost dbname=postgres user=postgres password=" + pw)

def read_file(file_name, table_name, sep):
    with open(file_name, 'r') as f:
        next(f)  # Skip the header row.
        cur.copy_from(f, table_name, sep=sep)

cur = conn.cursor()
cur.execute("""
    CREATE TABLE preppin_data_2019_04(
    date_col text,
    opponent text,
    result text,
    w_l text,
    hi_points text,
    hi_rebounds text,
    hi_assists text
)
""")

read_file('PD - ESPN stats.csv', 'preppin_data_2019_04', ';')

conn.commit()
conn.close()
