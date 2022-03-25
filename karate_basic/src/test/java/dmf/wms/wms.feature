Feature: WMS config settings for different scenarion
  
  Background:
    *  url 'https://tq1.wysemanagementsuite.com/ccm-web'
 
  @AUDIO_CONFIG  
  Scenario: Update configuration in CMS 
    * def session_headers = {Content-Type: 'application/json', Cookie: '', Accept: 'application/json,text/plain,charset=UTF-8,*/*'}
    Given headers session_headers
    And path 'login'
    When method post
    Then status 200 
    * def cookies = "JSESSIONID=" + responseCookies['JSESSIONID']['value']
    * def xrefheader = {Accept: '*/*', X-CSRF-Token: 'Fetch', cookie:'#(cookies)' }
    Given path  "open/fetchToken"
    And headers xrefheader
    When method get
    Then status 200  
    * def xsrftoken = responseHeaders['X-CSRF-Token'][0]
    * def payload = {j_username:"bala@dell.com",j_password:"Wyse#1234",X-CSRF-Token:'#(xsrftoken)'}
    Given path "j_spring_security_check"
    And request payload
    When method post
    Then status 200 
    And print "Response for final payload", response



  