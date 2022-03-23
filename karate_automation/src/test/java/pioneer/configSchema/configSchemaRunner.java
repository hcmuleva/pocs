package pioneer.configSchema;

import com.intuit.karate.junit5.Karate;

class configSchema {
    @Karate.Test
    Karate testTenants() {
        return Karate.run("configSchema").relativeTo(getClass());
    }    

}
