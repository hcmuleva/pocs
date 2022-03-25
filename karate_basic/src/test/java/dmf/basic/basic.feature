
@dmfcs12
Feature: Device registion scenario test

  Background:
    *  url 'http://localhost:8082'
   
  @testrailid1
  Scenario: Register device with proper payload
    Given path 'api/v1/device/createdevice'
    And request {"name":"UniqeName_hcm3", "type":"Windows2", "mac_address":"dummy"}
    When method post
    Then print response

  @testrailid2
  Scenario: Get all registred devices 
    Given path 'api/v1/device/alldevices'
    When method get
    Then print response  
  
  @testrailid3
  Scenario: Set Key and values in redis 
    Given path 'redis/set'
    And request {"key":"device2","value":"WINDOW DEVICE2"}
    When method post
    Then print response  
  @testrailid4
  Scenario: Get all keys from radis 
    Given path 'redis/keys'
    When method get
    Then print response 