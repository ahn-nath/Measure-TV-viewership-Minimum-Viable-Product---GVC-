import os
import pymongo
from pymongo import MongoClient

#Broadcaster Data
print('BROADCASTER DATA')
print()

#point the client at mongo URI
client = MongoClient(os.environ.get('MONGO_BROADCASTERDATA_URI'))

#list the database
print("Database List:")
for dbs in client.list_database_names():
    print(dbs)
print()

#select database
db = client['hybrid-dast']

#list the connection
print("Connection List:")
for col in db.list_collection_names():
    print(col)
print()

#Hybrid ID Data
print('HYBRID ID DATA')
print()

#point the client at mongo URI
client2 = MongoClient(os.environ.get('MONGO_HYBRIDIDDATA_URI'))

#list the database
print("Database List:")
for dbs in client2.list_database_names():
    print(dbs)
print()

#select database
db2 = client2['hybrid-id']

#list the connection
print("Connection List:")
for col in db2.list_collection_names():
    print(col)
print()