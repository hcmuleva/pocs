package pioneer.tenants;

import com.intuit.karate.junit5.Karate;

class datadriven {
    @Karate.Test
    Karate datadriven() {
        return Karate.run("datadriven").relativeTo(getClass());
    }    

}
