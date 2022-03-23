package pioneer.hooktest;

import com.intuit.karate.junit5.Karate;

class HookRunner {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("hooktest").relativeTo(getClass());
    }    

}
