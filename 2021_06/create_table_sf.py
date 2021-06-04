import snowflake.connector as snow
import os

csv_file = '2021_06.csv'
table = 'pd_2021_06'
schema = 'PREPPIN_DATA_2'
database = 'ANALYTICS'
stage = '@STG_PREPPIN_DATA'
pw = os.environ['transform']
acc = os.environ['sf_account']

conn = snow.connect(user='transform_user',
                    password=pw,
                    account=acc,
                    warehouse='TRANSFORM_WH',
                    database=database,
                    schema=schema,
                    role='TRANSFORM_ROLE')

cur = conn.cursor()

sql = f'USE {database}'
cur.execute(sql)

sql = f'USE SCHEMA {schema}'
cur.execute(sql)

sql = f"""
        CREATE TABLE IF NOT EXISTS {table} (
        player varchar, 
        money integer, 
        events integer, 
        tour varchar
        )"""
cur.execute(sql)

sql = f'PUT file://{csv_file} @STG_PREPPIN_DATA auto_compress=true'
cur.execute(sql)

sql = f"""
        COPY INTO {table} from {stage}/{csv_file}.gz 
        file_format = (type = "csv" 
                        field_delimiter = "," 
                        record_delimiter = "\n" 
                        FIELD_OPTIONALLY_ENCLOSED_BY = "0x22" 
                        skip_header = 1)
                        """
cur.execute(sql)

cur.close()
print(f'{csv_file} was succesfully uploaded to Snowflake as {database}.{schema}.{table}')
