package pioneer.policyMgmt;

import com.intuit.karate.junit5.Karate;

class TenantRunner {
    @Karate.Test
    Karate testTenants() {
        return Karate.run("policyApp").relativeTo(getClass());
    }    

}
