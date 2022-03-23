#Author: Calen Robinette
@configSchema
Feature: Testing UI Config Schema with automation
    Background:

    * url api_server
    * def Global_header = {'Content-type': 'application/json', 'x-tenant-id': '1', 'x-user-id' : 'Calen'}
    * print 'GLOBAL HEADER : ', Global_header
    * def id = "616d8dfcfb684151c0932935"

    * def configFile = 'classpath:' + 'pioneer/configSchema/data.json'
    * def util = call read('classpath:pioneer/reusable/reusable.feature')
    * def data = util.readjsonfile(configFile)
    * def request_body_01 = data.configSchemaTest_01

    @configSchemaTest_01
    Scenario: As a User, I want to test Successfully create UI Config Schema
        Given path '/v1/configSchema'
        And headers Global_header
        And headers {"Accept": "*"}
        And request request_body_01
        When method post
        Then status 200
        
		@configSchemaTest_02
    Scenario: As a User, I want to test Get the UI Config Schema with id = <id>
        Given path '/v1/configSchema/' + id
        And headers Global_header
        And request {}
        And headers {"Accept": "*"}
        When method get
        Then status 200
        
    

