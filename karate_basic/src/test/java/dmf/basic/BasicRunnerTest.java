package dmf.basic;

import com.intuit.karate.junit5.Karate;

class BasicRunnerTest {
    
    @Karate.Test
    Karate tesDeviceRegistry() {
        return Karate.run("basic").relativeTo(getClass());
    }    

}
