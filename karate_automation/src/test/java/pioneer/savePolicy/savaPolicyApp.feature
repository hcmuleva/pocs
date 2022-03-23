#Author: Testing
@savePolicyApp
Feature: Testing tenentapp with automation
    Background:

    * url api_server
  	* def Global_header = {'Content-type': 'application/json', 'x-tenant-id': '1', 'x-user-id' : 'test'}
    * print 'GLOBAL HEADER : ', Global_header
    * def id = "61652e2d3168ac71de60e6e6"
    * def configFile = 'classpath:' + 'pioneer/savePolicy/data.json'
    * def util = call read('classpath:pioneer/reusable/reusable.feature')
    * def data = util.readjsonfile(configFile)
    * def request_body_01 = data.savePolicyTest_01
      
    @savePolicyTest_01
    Scenario: As a User, I want to Save the policy by apis

        Given path '/v1/policy'
        And request request_body_01
        And headers Global_header
        When method post
        Then status 200
        
        
   

