package pioneer.tenants;

import com.intuit.karate.junit5.Karate;

class chainapi {
    @Karate.Test
    Karate chainapi() {
        return Karate.run("chainapi").relativeTo(getClass());
    }    

}
