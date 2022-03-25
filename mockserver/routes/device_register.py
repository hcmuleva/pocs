from datetime import datetime
from flask import Response
from flask import request, jsonify
from bson import ObjectId,json_util
import uuid

from utils.user_auth import *
import json
from . import routes
from flask import current_app
from pymongo import MongoClient
from resources.invalid_usage import InvalidUsage

@routes.route('/api/v1/device/alldevices',methods=['GET'])
def get_all_registered_devices():
    message=''
    code =202
    device_collection = current_app.config["DEVICE_COLLECTION"]
    
    device_db_record = device_collection.find()
    print("device_db_record",device_db_record)
    response = []
    for document in device_db_record:
        document['_id'] = str(document['_id'])
        response.append(document)
        print( "document", document)
    print("\ndevice_db_record\n",device_db_record)
    resp_data= json.dumps(response)
    print("\nResponse data\n",resp_data)
    headers={ 'content-type':'application/json',"deviceId":resp_data ,"Access-Control-Allow-Origin":"*"}

    response = Response(status=202, headers=headers)
    return response
    

@routes.route('/add', methods=['POST'])
def add_user():
    _json = request.json
    # _name = _json['name']
    # address = _json['mac_address']
    # uri ="mongodb://dmfuser:dmfpassword@localhost:27017/?authSource=dmfdb&authMechanism=SCRAM-SHA-256"
    # #databse_name=client[os.environ['dmfdb']]
    # databse_name=MongoClient(uri)

    device_collection = current_app.config["DEVICE_COLLECTION"]
    # validate the received values
    id = device_collection.insert_one({"name":"UniqeName_hcm2", "type":"Windows", "mac_address":"dummy"})
    resp = jsonify('User added successfully!')
    resp.status_code = 200
    return resp
	

@routes.route('/api/v1/device/createdevice',methods=['POST'])
def create_device():
    device_data = request.get_json()
    print("device_Data", device_data)
    
    device_collection = current_app.config["DEVICE_COLLECTION"]
    # device_db_record = device_collection.find_one({'name': device_data['name']})
    # if device_db_record:
    #     message='A resource with the specified identifier already exists'
    #     code=409
    #     raise InvalidUsage('A resource with the specified identifier already exists', 409)
    did=str(uuid.uuid4())
    device_data["did"]=did
    _id=device_collection.insert_one(device_data)
    print("Inserted device id ", _id)
    headers={ 'content-type':'application/json',"deviceId":str(_id) ,"Access-Control-Allow-Origin":"*"}

    response = Response(status=202, headers=headers)
    return response
   
@routes.route('/api/v1/device/updatedevice',methods=['PUT'])
def update_device():
    message=''
    code =202
    try:
        device_data = request.get_json()
        if not device_data:
            raise InvalidUsage('Invalid payload or action', 400)
        if 'device_id' in device_data:
            device_id =device_data['device_id']
            device_payload=device_data['payload']
            device_collection = current_app.config["DEVICE_COLLECTION"]
            updated=device_collection.find_one_and_update({'_id':device_id}, {"$set": device_payload}, upsert=False)
            headers={ 'content-type':'application/json',"deviceId":str(updated) ,"Access-Control-Allow-Origin":"*"}
            response = Response(status=202, headers=headers)
            return response
    except Exception as e:
        raise InvalidUsage(message, status_code=code)