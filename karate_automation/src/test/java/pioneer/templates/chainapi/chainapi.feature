#Author: Testing
@ignore
Feature: Testing Policy Mgmt
    Background:

    * url api_server
    * def Global_header = {'Content-type': 'application/json','Accept':'application/json,text/plain,*/*'}
    * print 'GLOBAL HEADER : ', Global_header

    @Sample_TC001
    Scenario: This is sample test
        Given path '/v1/tenent/getid'
        And request {}
        And headers {"Accept": "*"}
        When method get
        Then status 200

        * print 'response from API : ', response

    @createid
    Scenario: Inhertitance call
        Given path '/v1/tenent/createid'
        And request {}
        And headers {"Accept": "*"}
        When method get
        Then status 200
        #    {"id":123,
        #    "name":"ALPHA"
        #    "test"{"A":"H"}}

        * print 'response from API : ', response

    @testpolicy01
        Given path '/v1/tenent/policy/'
        And request {"data":"abc"}
        And headers {"Accept": "*"}
        When method post
        Then status 200

    @parameter
        #__arg = {"ID":1234}
        * def query_params = __arg
        * def uri_01 = "/v1/policy/" + query_params.ID
        Given path uri_01
        And request {}
        And headers {"Accept": "*"}
        When method get
        Then status 200
        * print "STATUS RET ", status






