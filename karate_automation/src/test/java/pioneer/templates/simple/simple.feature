#Author: Testing
#    {"id":123,
#    "name":"ALPHA"
#    "test"{"A":"H"}}

    #A - > B ->
@samplecall
Feature: Testing calling of another feature
    Background:

    * url api_server
    * def Global_header = {'Content-type': 'application/json','Accept':'application/json,text/plain,*/*'}
    * print 'GLOBAL HEADER : ', Global_header
    * call read('classpath:pioneer/policymgmt/policymgmt.feature@createid')
    * def id = response.id

#    * def resp = call read('classpath:pioneer/policymgmt/policymgmt.feature@createid')
#    * def id = resp.id
    #* def idA = response.test.A

    @Samp_TC001 @ignore
    Scenario: This is sample test
        Given path '/v1/tenent/getid/'
        And request {}
        And headers {"Accept": "*"}
        When method get
        Then status 200

    @SAMPLEID
    Scenario: This is A POST REQ
        * def resp = call read('classpath:pioneer/policymgmt/policymgmt.feature@createid')
        * def ID = resp.id

        * def arggs = {"ID":ID,"PARAM":"PAR1","PARAM2":"PAR2"}
        * def resp = call read('classpath:pioneer/policymgmt/policymgmt.feature@parameter') arggs

        * def uid = resp.uid
        * def uri_02 = "/v1/policy/del" + uid

        Given path uri_02
        And request {}
        And headers {"Accept": "*"}
        When method delete
        Then status 200






# 1. POST REQUEST CREATE SOME RECORD -> ID
# 2. BASED ON ID : GET REQ "/v1/policy/<ID>
# 3. RESPONSE = 200; API DELETE


