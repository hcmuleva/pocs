package pioneer.tenants;

import com.intuit.karate.junit5.Karate;

class usersession {
    @Karate.Test
    Karate testTenants() {
        return Karate.run("usersession").relativeTo(getClass());
    }    

}
