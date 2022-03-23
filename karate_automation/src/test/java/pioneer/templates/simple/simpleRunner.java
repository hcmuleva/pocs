package pioneer.tenants;

import com.intuit.karate.junit5.Karate;

class simple {
    @Karate.Test
    Karate simple() {
        return Karate.run("simple").relativeTo(getClass());
    }    

}
