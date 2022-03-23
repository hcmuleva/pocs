#Author: harish_muleva@dell.com
@US_PNRMCSG-458
Feature: verify Create Tenants feature
    This feature file covers both positive and negative scenario for create tenants.

    Background:
    * url 'http://localhost:8001'

    @TC_11111 @smoke
    Scenario: Create Tenants positive scenario.  
      * def payload_create_tenant =
        """
        {
          "name": "a",
          "customerId": "1",
          "customerName": "custname1",
          "address": {
            "street": "street1",
            "city": "city1",
            "state": "state1",
            "country": "country1",
            "zip" : 123456
          },
          "soldTo": {
            "first": "first1",
            "last": "last1",
            "email": "user1@gmail.com"
          },
          "itContact": {
            "email": "it1@gmail.com"
          },
        }
        """
      Given path 'api/v1/tenants'
      And request payload_create_tenant
      When method Post
      Then status 201
      And match response.name == 'a'