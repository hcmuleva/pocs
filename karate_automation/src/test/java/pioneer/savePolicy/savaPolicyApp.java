package pioneer.savePolicy;

import com.intuit.karate.junit5.Karate;

class SavePolicy {
    @Karate.Test
    Karate savePolicy() {
        return Karate.run("savaPolicyApp").relativeTo(getClass());
    }    

}
