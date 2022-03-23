#Author: Mrunmayi Kulkarni
@datasource_common
Feature: Running Common datasource with automation
    Background:

        * url api_server
        * def Global_header = {'Content-type': 'application/json', 'x-tenant-id': '1', 'x-user-id' : 'Mrunmayi'}
        * print 'GLOBAL HEADER : ', Global_header

        @datasource_common_01 @ignore
        Scenario: CREATE datasource for user - Success
        * def req_body =
        """
        {"name": "bookmark_karate",
         "projectId": "443b5db8-81a3-45bb-9209-be1192426ff1",
         "srcURL": "http://bookmark_karate.com/sompage.asp",
         "tenant": "1",
         "version": 0,
         "workspaceId": "2"}
         """
        Given path '/v1/datasource'
        And request req_body
        And headers Global_header
        When method post
        Then status 200