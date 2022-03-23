# Guidelines
## Intro
This is a Pioneer server test suite project that covers all features and test cases related to Pioneer features.
This suite will cover test cases for following service provided by Pioneer:
 - **FEATURE NEED TO UPDATE HERE(FEATURE1)**
 - **FEATURE NEED TO UPDATE HERE(FEATURE2)**
 - **FEATURE NEED TO UPDATE HERE(FEATURE3)**

The core framework used to build the feature and test cases are karate and Cucumber.
Karate framework is an effiecient REST API and GRAPHQL testing framework, that is build on top of Cucumber.
This follows all conventions of behavior driven development(BDD) and it can act as a live document for Pioneer platform.

The suite package structure shall be maintained as follows:
* `reusable`
This package will manage all reusable scripts that cuts acroos all pioneer services. This package can cover all direct and indiect APIs avaialble in Pioneer platform . Direct API file name will start with one `_` underscore and indirect API file name will start with two `__` double underscore.
* `common`
This package will manage use cases where multiple calls need to made accross services.
It will also maintain any wrapper that is required for any functionality that helps writing test cases easily. This pacakge shall have dependency only with _reuable_ pacakge.

* `json` 
This package will have API request body template of all APIs provied by Pioneer platform.
*`requestid`
We need to pass request id for all the request so that it will be helpful for debug purpose.

## Naving Conentions
### Java File
Java files can be created under any package. Java file name and class name MUST follow java coding guidelines.
- The file name and class name **MUST** be camelcase starting with capital letter.
    Examples: `PioneerSuite.java, PioneerSuiteParallelTest.java`
- **DO NOT** end the filename with `Test`. Only one filename is allowed to end the filename with `Test` (PioneerSuiteParallelTest.java). This is because Junit will pick every file ending with `Test` and run it independently when `mvn clean install ` is executed/ 
### Feature file 
Feature files can be created under `pioneer` package or its child packages only.
- The file name **must** follow snake case.
    -- Example: `_create_user.feature`
- All functional user story feature files **MUST** start with a user story number.
    -- Example: `PNRMCSG-426_logging_infrastructure.feature`
- The test setup and cleanup files for a perticular user story will follow below pattern.
    Feature file name: `PNRMCSG-422_create_user.feature`
    Setup file name:  `PNRMCSG-422_test_setup.feature`
    Cleanup file name:  `PNRMCSG-422_test_cleanup.feature`
  
  **NOTE:** Make sure the setup, cleanup and resuable feature scripts are marked as `@ignore` in order NOT to run during test suite execution.
  
  ## Tags
  Tagging is a way to filter out the test cases and it greatly helps selected test cases.
  Tags can be defined as Feature level or Scenario level. Following are the defined tags that can be used for IAM test cases:
  
| Tag Name | Description|
| Usage Level |
| :---:|:---: |
| :---:       |
|`@ignore` | To ignore a test case or feature|
|`Feature` `Scenario` | 
|`Feature`            | 
| `@US_<nnn>`|User Story ID of a function from JIRA|
| `@TC_<nnn>`|Test Case ID of a function from TestRail|
| `@smoke`   | Smoke test eligible scenario  |


