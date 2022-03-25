package dmf.wms;

import com.intuit.karate.junit5.Karate;

class WMSTest {

    @Karate.Test
    Karate testWms() {
        return Karate.run("wms").relativeTo(getClass());
    }  

}
