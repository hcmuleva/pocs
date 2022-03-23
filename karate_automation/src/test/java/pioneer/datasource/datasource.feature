#Author: Mrunmayi Kulkarni, Total Scneario : 7
@datasource
Feature: As a User, I want to test datasource with automation
    Background:

        * url api_server
        * def Global_header = {'Content-type': 'application/json', 'x-tenant-id': '1', 'x-user-id' : 'Mrunmayi'}
        * print 'GLOBAL HEADER : ', Global_header
        * def error_name = "name: must not be blank"
        * def error_forbidden = "Insufficient Privilages"


    @datasource01
    Scenario: As a User, I want to test GET datasource for user - Success
        Given path '/v1/datasource/507ca90b-f8e2-4fa5-99b6-b0ff3e1f34a1'
        And headers Global_header
        When method get
        Then status 200
        Then match response.projectId == "443b5db8-81a3-45bb-9209-be1192426ff6"

    @datasource02
    Scenario: As a User, I want to test UPDATE datasource for user - Success
        * def req_body =
            """
            {"id": "54505041-6fbb-4e0e-bc97-69455f4af056",
             "name": "bookmark_appstore_update",
             "projectId": "443b5db8-81a3-45bb-9209-be1192426ff1",
             "srcURL": "http://bookmark_appstore.com/sompage.asp",
             "tenant": "1",
             "version": 0,
             "workspaceId": "2"}
             """
        Given path '/v1/datasource/54505041-6fbb-4e0e-bc97-69455f4af056'
        And request req_body
        And headers Global_header
        When method put
        Then status 200

    @datasource03
    Scenario: DELETE datasource for user - Success
        Given path '/v1/datasource/54505041-6fbb-4e0e-bc97-69455f4af056'
        And headers Global_header
        When method delete
        Then status 200

    @datasource04
    Scenario: As a User, I want to test GET ALL datasource for project - Success
        Given path '/v1/project/443b5db8-81a3-45bb-9209-be1192426ff1/datasource'
        And headers Global_header
        When method get
        Then status 200
        # Then match response contains {"id":"a3bc6b76-3666-472c-bfff-b1438436d477"} ####

    @datasource05
    Scenario: As a User, I want to test GET datasource for user - Success
        * def resp = call read('classpath:pioneer/datasource_common/datasource_common.feature@datasource_common_01')
        * def response_id = resp.id
        * print 'respose Id from create is : ', response_id
        Given path '/v1/datasource/' + response_id
        And headers Global_header
        When method get
        Then status 200
        Then match response contains {"name": "bookmark_karate"}

    @datasource06
    Scenario Outline: As a User, I want to test <Title_data> Failure scenarios
        Given path '/v1/datasource'
        # And request datasourceWithoutName
        And request <req_body_data>
        And headers Global_header
        When method post
        Then status <response_code>
        Then match response.message = <response_msg>

        Examples:
            | req_body_data         | response_code | response_msg    | Title_data      |
            | datasourceWithoutName | 400           | error_name      | "WithoutName"   |
            | datasourceNotAssoUser | 403           | error_forbidden | "NotAssoUser"   |