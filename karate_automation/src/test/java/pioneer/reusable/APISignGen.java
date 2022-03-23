/*
 * All copy right related templated need to applied (This should be aprt of IDE setup)
 *
 */

package pioneer.reusable;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.time.Instant;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

public class APISignGen {

    private APISignGen () {

    }

    public static Map<String, String> createSignHeaders (
            String sharedKey, String secretKey, String secretPrefix) {

        Map<String, String> signHeaders = new HashMap<> ();
        Instant instant = Instant.now ();
        final byte[] data = Base64.getEncoder ().encode (instant.toString ().getBytes ());
        String secret = secretPrefix + secretKey;
        try {
            Mac mac = Mac.getInstance ("HmacSHA256");
            mac.init (new SecretKeySpec (secret.getBytes (), "HmacSHA256"));
            final byte[] signature = mac.doFinal (data);
            String apiSig = String.format (
                    "HmacSHA256;Credential:%s;SignedHeaders:SignedDate;Signature:%s", sharedKey,
                    Base64.getEncoder().encodeToString (signature));
            signHeaders.put ("HSDP-API-Signature", apiSig);
            signHeaders.put ("SignedDate", instant.toString ());

        } catch (NoSuchAlgorithmException | InvalidKeyException e) {
            Logger.getGlobal ().warning (e.getMessage ());
        }
        return signHeaders;
    }


    public static Map<String, String> createinvalidSignHeaders (
            String sharedKey, String secretKey, String secretPrefix) {
        Map<String, String> invalidsignHeaders = new HashMap<> ();

        Instant instant = Instant.now ();
        final byte[] data = Base64.getEncoder ().encode (instant.toString ().getBytes ());
        String secret = secretPrefix + secretKey;
        try {
            Mac mac = Mac.getInstance ("HmacSHA256");
            mac.init (new SecretKeySpec (secret.getBytes (), "HmacSHA256"));
            final byte[] signature = mac.doFinal (data);
            String apiSig = String.format (
                    "HmacSHA256;Credential:%s;SignedHeaders:SignedDate;Signature:%s", sharedKey,
                    Base64.getEncoder().encodeToString (signature));
            invalidsignHeaders.put("hsdp-api-sign", apiSig);
            invalidsignHeaders.put ("SignedDatessss", instant.toString ());

        } catch (NoSuchAlgorithmException | InvalidKeyException e) {
            Logger.getGlobal ().warning (e.getMessage ());
        }
        return invalidsignHeaders;
    }
}




