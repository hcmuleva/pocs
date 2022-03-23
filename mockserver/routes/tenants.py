
from flask import current_app,request, jsonify
from flask import Response
import json
from bson.objectid import ObjectId
from utils.user_auth import *
from pymongo import MongoClient
from bson import ObjectId,json_util
from resources.tenants_error import InternalServerError,SchemaValidationError,TenantAlreadyExistsError,UpdatingTenantError,DeletingTenantError,TenantNotExistsError,InvalidPayLoadError,InvalidTokenError
from resources.invalid_usage import InvalidUsage
from . import routes
import uuid 
@routes.errorhandler(InvalidUsage)
def handle_invalid_usage(error):
    response = jsonify(error.to_dict())
    response.status_code = error.status_code
    print("Response ", response)
    return response

@routes.route('/api/v1/tenants',methods=['POST'])
def create_tenant():
    message=''
    code =202
    try:
        print("Header before ",request.headers)
        bearertoken = request.headers.get('Accesstoken')
        if not bearertoken:
            print("Token exception ")
            message='Missing or invalid access token'
            code=401
            raise InvalidUsage('Missing or invalid access token',401)  
        print("bearertoken ",bearertoken)
        jwt_arr=bearertoken.split('Bearer ')
        print("Token after split",jwt_arr)
        try:
            payload = decode_auth_token(jwt_arr[1])
            print("Payload ",payload)
        except Exception as decode:
            message='Missing or invalid access token'
            code=401
            raise InvalidUsage('Missing or invalid access token', 401)
        tenant_data = request.get_json()
        if not tenant_data:
            raise InvalidUsage('Invalid payload or action', 400)
        
        tenants_collection = current_app.config["TENANTS_COLLECTION"]
        tenant_db_record = tenants_collection.find_one({'name': tenant_data['name']})
        if tenant_db_record:
            message='A resource with the specified identifier already exists'
            code=409
            raise InvalidUsage('A resource with the specified identifier already exists', 409)
        rid=str(uuid.uuid4())
        tenant_data["rid"]=rid
        _id=tenants_collection.insert(tenant_data)
        print("Inserted tenant id ", _id)
        headers={ 'content-type':'application/json',"tenant":str(_id) ,'location':f"/api/v1/queue/{rid}","Access-Control-Allow-Origin":"*"}
        
        response = Response(status=202, headers=headers)
        print("Before return ",response)
        return response
    except Exception as e:
        print("HCM Exception ",e )
        raise InvalidUsage(message, status_code=code)

@routes.route('/api/v1/tenant/<id>',methods=['GET'])
def get_tenant(id):
    try:
        tenants_collection = current_app.config["TENANTS_COLLECTION"]
        tenant_exist = tenants_collection.find_one({'user_id': id})
        if not tenant_exist:
            print("tenants does not exist ")
            response = Response(status=409)
            response.headers["Access-Control-Allow-Origin"] = "*"
            response.response['error']="Tenent does not exist"
            return response
        response = Response(status=202)
        response.headers["Access-Control-Allow-Origin"] = "*"
        response.response['tenant']=tenant_exist
        return response   
    except Exception as e:
        raise InvalidUsage('Invalid  Tenant ID', status_code=430)

@routes.route('/api/v1/tenants/<tid>', methods=["GET"])
def getTenant(tid):
    message=''
    code =202
    try:
        print("Header before ",request.headers)
        bearertoken = request.headers.get('Accesstoken')
        if not bearertoken:
            print("Token exception ")
            message='Missing or invalid access token'
            code=401
            raise InvalidUsage('Missing or invalid access token',401) 
        tenants_collection = current_app.config["TENANTS_COLLECTION"]
        tenant_db_record = tenants_collection.find_one({'_id': ObjectId(tid)})
        message={"response":tenant_db_record}
        headers={ 'content-type':'application/json',"Access-Control-Allow-Origin":"*"}
        
        resp= Response(
           
            status=200,
            headers=headers
        )
        message=json.loads(json_util.dumps(message))
        resp['set_data']=message
        return resp
    except Exception as e:
        print("HCM Exception ",e )
        raise InvalidUsage(message, status_code=code)