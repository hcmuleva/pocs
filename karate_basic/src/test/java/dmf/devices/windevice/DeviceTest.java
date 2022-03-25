package dmf.devices.windevice;

import com.intuit.karate.junit5.Karate;

class DeviceTest {

    @Karate.Test
    Karate testDevice() {
        return Karate.run("device").relativeTo(getClass());
    }  

}
