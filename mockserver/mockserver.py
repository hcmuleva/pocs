import os
from flask import Flask
from flask_cors import CORS
from pymongo import MongoClient
from routes import routes
app = Flask(__name__)
CORS(app)
mongodb_username='mongoadmin'
mongod_password='secret'
mongodb_database='mockdb'
client = MongoClient('mongodb://' + mongodb_username + ':' +mongod_password+ '@mongodb:27017/')
databse_name=client[mongodb_database]
user_collection=databse_name.user
tenants_collection=databse_name.tenants
subscription_collection=databse_name.subscription
app.config["USER_COLLECTION"]=user_collection
app.config["TENANTS_COLLECTION"]=tenants_collection
app.config["subscription_COLLECTION"]=subscription_collection
"""Add all routes to blueprint this will register"""
app.register_blueprint(routes)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8082, debug=True)