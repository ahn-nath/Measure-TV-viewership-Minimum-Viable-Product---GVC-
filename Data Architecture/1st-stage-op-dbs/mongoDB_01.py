#1st Stage - connect to database from Python [Mongo] - NT
import os
import pymongo
from pymongo import MongoClient

#Broadcaster data
client = MongoClient(os.environ.get('MONGO_BROAD'))
db = client["channels"]


print("List of databases \n--------------------")

#list database names
for x in client.list_database_names():
    print(x)
    
    
print("List of collections \n--------------------")

#list collection names
for x in db.list_collection_names():
    print(x)
    

print("List of documents for the 'channels' collection \n--------------------")

#list docs names
for x in db.channels.find( {} ):
    print(x)
