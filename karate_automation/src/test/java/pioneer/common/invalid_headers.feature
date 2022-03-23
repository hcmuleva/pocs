@ignore 
Feature: Invalid header for User Management and tenants API 

    Scenario: Using the invalid header set, test the user or tenant API
        Then print "\n\n****Inside second scenario***\n\n"
         * def invalidHeader = 'Bearer dddfff-ddshhhh-ddfdfg-ddfdfd0-ddhnnhgg'
        * set invalid_headers
            |path   0     |   1                 | 2                   |
            |Content-type |   'application/json'|   'application/json'|
            |Accept       |   'application/json'|   'application/json'|
            |API-Version  |   0                 |   1                 |
        * table headersWithCT
            |headers            |  expectedStatus     |
            | invalid_headers[0]| 400                 |
            | invalid_headers[1]| 401                 |
            | invalid_headers[2]| 406                 |
