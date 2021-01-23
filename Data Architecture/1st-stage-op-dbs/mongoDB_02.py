#1st Stage - connect to database from Python [Mongo] - NT
import os
import pymongo
from pymongo import MongoClient

#Hybrid ID data
client = MongoClient(os.environ.get('MONGO_HYBRID'))
db = client["hybrid-id"]


print("List of databases \n--------------------")

#list database names
for x in client.list_database_names():
    print(x)
    
    
print("List of collections \n--------------------")

#list collection names
for x in db.list_collection_names():
    print(x)
    

print("List of documents for the 'devices' collection \n--------------------")

#list docs names
for x in db.devices.find( {} ):
    print(x)
