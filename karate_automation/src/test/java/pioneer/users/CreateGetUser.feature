@user
Feature: verify Create Get User feature
    This feature file covers both positive and negative scenario for create user

    Background:
    * url 'http://localhost:8001'

    @user_create
    Scenario: Create user positive scenario.  
      * def payload_create_user =
        """
        {
          "username": "manju",
          "description": "manjax description",
        }
        """
      Given path 'user'
      And request payload_create_user
      When method Post
      Then status 201
      And match payload_create_user.username == response.username
      And match payload_create_user.description == response.description

    @user_get
    Scenario: Get user positive scenario.  
      * def user_id = 2
      Given path 'user/' + user_id
      When method Get
      Then status 200
      And match user_id == response.user_id
