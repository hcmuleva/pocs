package dmf;

import com.intuit.karate.junit5.Karate;

class DMFRunner {
    
    @Karate.Test
    Karate tesDevice() {
        return Karate.run("dmf").relativeTo(getClass());
    }    

}
