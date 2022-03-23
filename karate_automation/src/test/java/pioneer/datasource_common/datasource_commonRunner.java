package pioneer.datasource_common;

import com.intuit.karate.junit5.Karate;

class datasource_commonRunner {
    @Karate.Test
    Karate testTenants() {
        return Karate.run("datasource_common").relativeTo(getClass());
    }    

}
