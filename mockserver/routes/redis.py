from datetime import datetime
from flask import Response
from flask import request, jsonify
from utils.user_auth import *
import json
from . import routes
from flask import current_app


@routes.route('/redis/set',methods=['POST'])
def set_redis_key_values():
    radis_collection = current_app.config["REDIS_COLLECTION"]
    radis_data = request.get_json()
    print("recieved data", radis_data)
    key =radis_data['key']
    value=radis_data['value']
    radis_collection.set(key, value)
    resp = radis_collection.get(key)
    print(resp)
    resp_val=resp.decode()
    print(resp_val)
    result_data={"result":resp_val}
    print("RESULT_DATA BEFOREDECODE",result_data)
    return jsonify({"response": result_data}), 201  
    
@routes.route('/redis/keys',methods=['GET'])
def get_redis_keys():
    radis_collection = current_app.config["REDIS_COLLECTION"]
    all_keys=radis_collection.keys("*")
    mylist=""
    for elm in all_keys:
        val =radis_collection.get(elm)
        mylist=mylist+","+elm.decode()+ " value="+val.decode()+ " "
    print(mylist)
    #result_keys_str=','.join(all_keys)
    result_data={"result":mylist}
    return jsonify({"response": mylist}), 201    
