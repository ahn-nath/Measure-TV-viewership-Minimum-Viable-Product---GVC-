import os
import snowflake.connector

conn = snowflake.connector.connect(
                user=os.environ.get('snowflake_user'),
                password=os.environ.get('snowflake_pass'),
                account=os.environ.get('snowflake_acc'))