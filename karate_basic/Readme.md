
Command to run test are as follows: e.g. testrailid1
```
    mvn test -Dkarate.options="--tags @testrailid1"
```
if you want to pass some environment variable e.g. dev
```
    mvn test -Dkarate.options="--tags  @testrailid1" -Dkarate.env=dev
```