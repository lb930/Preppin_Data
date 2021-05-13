import psycopg2

conn = psycopg2.connect(
    "host=localhost dbname=postgres user=postgres password=123")
cur = conn.cursor()
cur.execute("""
    CREATE TABLE preppin_data_2019_01(
    Dealership text,
    Red_Cars integer,
    Silver_Cars integer,
    Black_Cars integer,
    Blue_Cars integer,
    When_sold_month integer,
    When_sold_year integer
)
""")

with open('2019 Week 1.csv', 'r') as f:
    next(f)  # Skip the header row.
    cur.copy_from(f, 'preppin_data_2019_01', sep=',')

conn.commit()
