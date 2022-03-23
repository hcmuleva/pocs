#Author: Testing
@policyApp
Feature: Testing tenentapp with automation
    Background:

    * url api_server
    * def Global_header = {'Content-type': 'application/json', 'x-tenant-id': '1', 'x-user-id' : 'Surya'}
    * callonce read('classpath:pioneer/savePolicy/savaPolicyApp.feature@savePolicyTest_01')
    * def resource_id = response.id
    * def contextType = response.contextType
    * def contextId = response.contextId
    * print 'GLOBAL HEADER : ', Global_header

    @policyTest_01
    Scenario: As a User, I want to perform a demo test
        Given path '/v1/policy/'+resource_id
        And headers Global_header
        And request {}
        And headers {"Accept": "*"}
        When method get
        Then status 200
	
	@policyTest_02
    Scenario: As a User, I want to get the policy settings with contextId and context type
    	* def contextUrl = '/v1/policy/'+ contextType+'/'+ contextId
        Given path contextUrl
        And headers Global_header
        And request {}
        And headers {"Accept": "*"}
        When method get
        Then status 200
        
    @policyTest_03
    Scenario: As a User, I want to get the policy settings with tenantId
        Given path '/v1/policy'
        And headers Global_header
        And request {}
        And headers {"Accept": "*"}
        When method get
        Then status 200
        
    

