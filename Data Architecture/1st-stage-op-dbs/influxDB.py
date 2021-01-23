#1st Stage - connect to database from Python [Influx] - NT
import os
import influxdb_client
from influxdb_client.client import query_api

client = influxdb_client.InfluxDBClient(url = os.environ.get('INFLUX_URL'), token = os.environ.get('INFLUX_TOKEN'), org = os.environ.get('INFLUX_ORG'))

# query
query_api = client.query_api()
query = os.environ.get('INFLUX_QUERY')

result = client.query_api().query(org = os.environ.get('INFLUX_ORG'), query = query)

# printing general info
for table in result:
    print(table)

# printing records
results = []
for table in result:
    for record in table.records:
        results.append((record.get_value(), record.get_field()))

print(results)
