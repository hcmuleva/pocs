#Author: Testing
@ignore
Feature: Testing template for userSession api with automation
    Background:

        * url api_server
        * def Global_header = {'Content-type': 'application/json','x-tenant-id':'1','x-user-id':'1'}

        * def api_path = '/orchestrator/api/v1/user-session'

        * def configFile = 'classpath:' + 'pioneer/configSchema/data.json'
        * def util = call read('classpath:pioneer/reusable/reusable.feature')
        * def data = util.readjsonfile(configFile)

        * def response_body_01 = data.configSchemaTest_01
        * def emptyJson = data.emptyJson
        * def nullJson = data.nullJson
        * def invalidStateInPayload = data.invalidStateInPayload
        * def userdata1 = data.userdata1
        * def userdata2 = data.userdata2
        * def userdata3 = data.userdata3


    @updateUserSessionSuccessfultemplate
    Scenario: As a user, I want to test Update user session successful using api
        * def req_body = anum_testdata1
        * def response_body = response_body_01
        Given path api_path
        And request req_body
        And headers Global_header
        When method put
        Then status 200
        Then match response == response_body

    @updateUserSessionSuccessSeriestemplate
    Scenario Outline: As a user, i want to test update user session pass Series for <title>.
        Given path api_path
        And request <req_body_data>
        And headers Global_header
        When method put
        Then status <error_code>
        And match response.message == <status_code>


         Examples:
            | title               | req_body_data             | error_code    | status_code     |
            | "uservalue1"        | userdata1                 | 200           | 'Success'       |
            | "uservalue2"        | userdata2                 | 201           | 'Success'       |
            | "uservalue4"        | userdata3                 | 200           | 'Success'       |



    @updateUserSessionFailuretemplate
    Scenario Outline: As a user, i want to test update user session failed - Bad Payload for <title>.
        Given path api_path
        And request <req_body_data>
        And headers Global_header
        When method put
        Then status <error_code>
        And match response.message == <status_code>


         Examples:
            | title               | req_body_data             | error_code    | status_code   |
            | "EmptyJSON"         | emptyJson                 | 400           | 'BAD_REQUEST' |
            | "NullJSON"          | nullJson                  | 400           | 'BAD_REQUEST' |
            | "InvalidJSON"       | invalidStateInPayload     | 400           | 'BAD_REQUEST' |

