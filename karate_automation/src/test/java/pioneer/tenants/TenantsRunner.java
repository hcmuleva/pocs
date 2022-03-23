package pioneer.tenants;

import com.intuit.karate.junit5.Karate;

class TenantsRunner {
    @Karate.Test
    Karate testTenants() {
        return Karate.run("tenants").relativeTo(getClass());
    }    

}
