import os
from flask import Flask
from flask_cors import CORS
from pymongo import MongoClient
from routes import routes
import redis
app = Flask(__name__)
CORS(app)
r = redis.Redis(host="localhost",port=6379,  db=0)
#r = redis.Redis(host=os.environ['REDIS_HOSTNAME'],port=6379,  db=0)

#app.config["MONGO_URI"] = 'mongodb://' + os.environ['MONGODB_USERNAME'] + ':' + os.environ['MONGODB_PASSWORD'] + '@' + os.environ['MONGODB_HOSTNAME'] + ':27017/' + os.environ['MONGODB_DATABASE']
# print("os.environ['MONGODB_USERNAME']",os.environ['MONGODB_USERNAME'])
# print("os.environ['MONGODB_PASSWORD']",os.environ['MONGODB_PASSWORD'])
# print("os.environ['MONGODB_HOSTNAME']",os.environ['MONGODB_HOSTNAME'])
user_name="dd"
password= "dd"
host_name="localhost"
dbname=   "dd"
# user_name=os.environ['MONGODB_USERNAME']
# password= os.environ['MONGODB_PASSWORD']
# host_name=os.environ['MONGODB_HOSTNAME']
# dbname=   os.environ['MONGODB_DATABASE']
print("REcieved user_name", user_name, " password ", password, " hostname", host_name)
#client = MongoClient('mongodb://' + os.environ['MONGODB_USERNAME'] + ':' + os.environ['MONGODB_PASSWORD'] + '@' + os.environ['MONGODB_HOSTNAME'] + ':27017/')
#client = MongoClient('mongodb://dmfuser:dmfpassword@localhost:27017/dmfdb')
#uri ="mongodb://dmfuser:dmfpassword@localhost:27017/?authSource=dmfdb&authMechanism=SCRAM-SHA-256"
uri ="mongodb://"+user_name+":"+password+"@"+host_name+":27017/?authSource="+dbname+"&authMechanism=SCRAM-SHA-256"
client=MongoClient(uri)
databse_name=client['dmfdb']
user_collection=databse_name.user
tenants_collection=databse_name.tenants
subscription_collection=databse_name.subscription
device_collection=databse_name.device
app.config["USER_COLLECTION"]=user_collection
app.config["TENANTS_COLLECTION"]=tenants_collection
app.config["subscription_COLLECTION"]=subscription_collection
app.config["DEVICE_COLLECTION"]=device_collection
app.config["REDIS_COLLECTION"]=r
"""Add all routes to blueprint this will register"""
app.register_blueprint(routes)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8084, debug=True)