#Author: All JS Re-usable Scripts
@resusableJS @ignore
Feature:
    Scenario:
    * def sleep =
          """
          function(seconds){
            java.lang.Thread.sleep(1*1000*seconds);
          }
          """

    * def testdef =
          """
          function(arg){
            karate.log('FIRST VALUE ' + arg.first);
            karate.log('SEC VALUE   ' + arg.sec);

          }
          """

    * def readjsonfile =
          """
          function(filename){
            karate.log('reading json file : ' + filename);
            try {
              config = karate.read (filename);
              karate.log('DATA : ' + config);
              return config;
            } catch (e) {
              karate.log ("Failed to perform ", e.message);
              return 'Failure';
            }
          }
          """

    * def writejsonfile =
          """
          function(filename,data){
            karate.log('writing to json file : ' + filename);
            karate.log('content : ' + (data));
            try {
              karate.write((data),filename);
              //config = karate.read ('target:' + filename);
              //karate.log('DATA : ' + config);
              return 'Success';
            } catch (e) {
              karate.log ("Failed to perform ", e.message);
              return 'Failure';
            }
          }
          """

      * def runcommand =
            """
                function(line) {
                    try {
                      karate.log('Executing Command : ' + line);
                      var proc = karate.fork({redirectErrorStream: false, useShell: true, line: line });
                      proc.waitSync();
                      //karate.set('sysOut', proc.sysOut);
                      //karate.set('sysErr', proc.sysErr);
                      //karate.set('exitCode', proc.exitCode);
                      karate.log('Output : ' + proc.sysOut);
                      return {"output":proc.sysOut,"exitcode":proc.exitCode,"Error":proc.sysErr}
                    } catch (e) {
                      karate.log ("Failed to perform ", e.message);
                      return 'Failure';
                    }
              }
            """


    * def now =
      """
        function() {
          return java.lang.System.currentTimeMillis()
        }
      """

    * def uuid =
       """
         function() {
           return java.util.UUID.randomUUID() + ''
         }
       """







               
