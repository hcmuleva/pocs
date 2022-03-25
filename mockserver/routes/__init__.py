from flask import Blueprint
routes = Blueprint('routes', __name__)
from .user import *
from .tenants import *
from .device_register import *
from .redis import *