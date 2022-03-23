package pioneer;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.json.simple.JSONObject;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

class PioneerSuiteParallelTest {

    @Test
    void testParallel() {
        int total_pass = 0;
        int total_fail = 0;
        Results userresults = Runner.path("classpath:pioneer/users").parallel(1);
        Results tenantresults = Runner.path("classpath:pioneer/tenants").parallel(1);
        total_pass += userresults.getPassCount();
        total_pass += tenantresults.getPassCount();
        total_fail += userresults.getFailCount();
        total_fail += tenantresults.getFailCount();
        System.out.println("\n\n\n\n\n****************Result Generated**************\n\n\n\n");
        JSONObject obj = new JSONObject();
        obj.put("total_passed", total_pass);
        obj.put("total_failed", total_fail);
        FileWriter file = null;
        try {
            Path path = Paths.get(userresults.getReportDir(), "teresult.txt");
            file = new FileWriter(path.toFile());
            file.write(obj.toJSONString());
        } catch (IOException e) {
            System.out.println(e);
        } finally {
            try {
                file.flush();
                file.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        System.out.println("\n Total pass " + total_pass + "    Total Fail " + total_fail + "   Reuslt dir:: " + userresults.getReportDir());
        System.out.println("\n\n\n\n\n****************Result End**************\n\n\n\n");

        generateReport(userresults.getReportDir());
        generateReport(tenantresults.getReportDir());

        assertEquals(0, userresults.getFailCount(), userresults.getErrorMessages());
        assertEquals(0, tenantresults.getFailCount(), tenantresults.getErrorMessages());
    }

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "demo");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}
