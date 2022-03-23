#Author: Mansi_Bhalerao, TOTAL TC : 4
@registeredDevice
Feature: As a User, I want to test device api with automation
    Background:

        * url api_server
        * def Global_header = {'Content-type': 'application/json','x-tenant-id':'1','x-user-id':'1'}
        * print 'GLOBAL HEADER : ', Global_header
        

   @getDeviceForServiceTagSuccessful
    scenario: As a User, I want to test Get device details for the given service tag
    	* def api_path = '/orchestrator/api/v1/device/C67134343434'
    	* def get_header = {'x-tenant-id':'1','x-user-id':'1'}
    	* def response_body = deviceDetails
    	Given path api_path
        And headers get_header
        When method get
        Then status 200
        Then match response == response_body
        
        
    @updateDeviceForServiceTagSuccessful 	
    Scenario: As a User, I want to test Update registered device for the given service tag successful
    	* def api_path = '/orchestrator/api/v1/device-register/C67134343434'
        * def req_body = deviceDetails
        * def response_body = updatedDeviceDetails
        Given path api_path
        And request req_body
        And headers Global_header
        When method put
        Then status 200
        Then match response == response_body


    @updateDeviceForServiceTagFailure
    Scenario Outline: As a User, I want to test update device for the given service tag failed - <Title_data> Bad Payload.
    	* def api_path = '/orchestrator/api/v1/device-register/C67134343434'
        Given path api_path
        And request <req_body_data>
        And headers Global_header
        When method put
        Then status <error_code>
        And match response.status == <status_code>
        And match response.message == <message>


         Examples:
            | req_body_data             | error_code    | status_code   |  message      	     	 | Title_data       |
            | emptyDeviceJson           | 400           | 'BAD_REQUEST' | 'Bad payload'				 | "EmptyJSON"      |
            | nullDeviceJson            | 400           | 'BAD_REQUEST' | 'Bad payload'              | "NullJson"       |
          





