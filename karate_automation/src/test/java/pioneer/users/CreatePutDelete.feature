@user
Feature: verify Update Delete User feature
    This feature file covers both positive and negative scenario for create user

    Background:
    * url 'http://localhost:8001'

    @user_update
    Scenario: Update user positive scenario.  
      * def payload_update_user =
        """
        {
          "username": "pluto",
          "description": "updated_pluto",
        }
        """
      Given path 'user'
      And request payload_update_user
      When method Put
      Then status 200
      And match payload_update_user.username == response.username
      And match payload_update_user.description == response.description

    @user_delete
    Scenario: Get user positive scenario.  
      * def user_id = 4
      Given path 'user/' + user_id
      When method Delete
      Then status 200
      And match user_id == response.user_id
