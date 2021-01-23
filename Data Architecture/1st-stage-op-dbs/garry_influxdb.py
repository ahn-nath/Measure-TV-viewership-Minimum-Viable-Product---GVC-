import os
import influxdb_client
from influxdb_client.client import query_api

my_url = os.environ.get('influxdb_url')
my_token = os.environ.get('influxdb_token')
my_org = os.environ.get('influxdb_org')

client = influxdb_client.InfluxDBClient(url=my_url,token=my_token,org=my_org)

queryapi = client.query_api()
data_frame = queryapi.query_data_frame('from(bucket: "hybrid-dast")'
  '|> range(start: -10m)'
  '|> filter(fn: (r) => r["_measurement"] == "pings" and r.channel == "57ea31912bb6581000092e89")'
)
data_frame.to_csv('1st-stage-op-dbs/test.csv')