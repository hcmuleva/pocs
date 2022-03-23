/*
 * All copy right related templated need to applied (This should be aprt of IDE setup)
 *
 */


package pioneer.reusable;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.TimeZone;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

public class GenerateJWTToken {
    private static final String ZONE_UTC = "UTC";
    private static final int JWT_TOKEN_VALIDITY = 118 * 60 * 1000;

    private GenerateJWTToken () {

    }

    public static String generateJWTToken (String serviceId, String privateKey, String pioneer_host) {

        System.out.println ("in generate jwt token");

        HashMap jwtHeader = new HashMap<> (3);
        jwtHeader.put ("alg", "RS256");
        jwtHeader.put ("typ", "JWT");
        Date issuedAt = Calendar.getInstance (TimeZone.getTimeZone (ZONE_UTC)).getTime ();
        Date expireAfter = Calendar.getInstance (TimeZone.getTimeZone (ZONE_UTC)).getTime ();
        expireAfter.setTime (expireAfter.getTime () + JWT_TOKEN_VALIDITY);
        String subject = serviceId;

        return Jwts
                .builder ()
                .setHeader (jwtHeader)
                .setAudience (
                        pioneer_host + "/oauth2/access_token")
                .setIssuer (subject)
                .setSubject (subject)
                .setExpiration (expireAfter)
                .signWith (SignatureAlgorithm.RS256, KeyGeneratorHelper.getKeyFromString (privateKey))
                .compact ();
    }

}
