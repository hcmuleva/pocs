Feature: Device settings scenario test
  
  Background:
    *  url 'http://100.105.116.10'
   
  @SET_AUDIO
  Scenario: Set audio setting to device
    Given path 'changesettings'
    And request {"Volume":60}
    When method post
    Then print response

  @GET_AUDIO
  Scenario: Read audio setting from device
    Given path 'audiosettings'
    When method post
    Then print response
  