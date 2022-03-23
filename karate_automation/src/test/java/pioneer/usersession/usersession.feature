#Author: Mansi_Bhalerao, TOTAL TC : 4
@userSession
Feature: As a User, I want to test userSession api with automation
    Background:

        * url api_server
        * def Global_header = {'Content-type': 'application/json','x-tenant-id':'1','x-user-id':'1'}
        * print 'GLOBAL HEADER : ', Global_header
        * def api_path = '/orchestrator/api/v1/user-session'

    @updateUserSessionSuccessful
    Scenario: As a User, I want to test Update user session successful
        * def req_body = updateUserSession
        * def response_body = updatedUserSession
        Given path api_path
        And request req_body
        And headers Global_header
        When method put
        Then status 200
        Then match response == response_body


    @updateUserSessionFailure
    Scenario Outline: As a User, I want to test update user session failed - <Title_data> Bad Payload.
        Given path api_path
        And request <req_body_data>
        And headers Global_header
        When method put
        Then status <error_code>
        And match response.status == <status_code>
        And match response.message == <message>


         Examples:
            | Title_data    | req_body_data             | error_code    | status_code   |  message      		        		 |
            | "EmptyJSON"   | emptyJson                 | 400           | 'BAD_REQUEST' | 'Bad payload'			            	 |
            | "NullJSON"    | nullJson                  | 400           | 'BAD_REQUEST' | 'Bad payload'                          |
            | "InvalidJSON" | invalidStateInPayload     | 400           | 'BAD_REQUEST' | 'state: Must not be blank'             |





