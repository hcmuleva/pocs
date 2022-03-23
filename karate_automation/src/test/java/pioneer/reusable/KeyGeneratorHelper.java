/**
 * This class implementation uses Bouncy Castle (http://www.bouncycastle.org) library
 * (bcprov-jdk15-1.45.jar) under MIT license, to programmatically generate self-signed certificate.
 */


package pioneer.reusable;

import java.io.IOException;
import java.io.StringWriter;
import java.math.BigInteger;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.SecureRandom;
import java.security.Security;
import java.security.SignatureException;
import java.security.cert.CertificateEncodingException;
import java.security.cert.X509Certificate;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

import javax.security.auth.x500.X500Principal;

import org.apache.commons.codec.binary.Base64;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.bouncycastle.openssl.PEMWriter;
import org.bouncycastle.x509.X509V3CertificateGenerator;

/**
 * Util class to generate RS256 private key and X509 certificate
 *
 * @author Harish Muleva
 */
public class KeyGeneratorHelper {

    public static final String ALGORITHM = "RSA";
    public static final int KEY_SIZE = 2048;
    public static final String PROVIDER = "BC";
    public static final String SIGNATURE_ALGORITHM = "SHA256WithRSAEncryption";

    public static KeyPair getKeyPair () throws NoSuchProviderException, NoSuchAlgorithmException {

        Security.addProvider (new BouncyCastleProvider ());

        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance (ALGORITHM, PROVIDER);
        keyPairGenerator.initialize (KEY_SIZE, new SecureRandom ());
        return keyPairGenerator.generateKeyPair ();

    }

    public static String getPrivateKey (KeyPair keyPair) throws IOException {

        try (StringWriter writer = new StringWriter (); PEMWriter pemWriter = new PEMWriter (writer);) {

            pemWriter.writeObject (keyPair.getPrivate ());
            pemWriter.flush ();
            return writer.toString ();
        }
    }

    public static String generateCertificate (KeyPair keyPair, String clientId, int validity) throws
            IOException,
            NoSuchAlgorithmException,
            CertificateEncodingException,
            NoSuchProviderException,
            InvalidKeyException,
            SignatureException {

        Calendar cal = Calendar.getInstance (TimeZone.getTimeZone ("UTC"));
        long current = cal.getTimeInMillis ();
        cal.add (Calendar.MONTH, validity);
        long naf = cal.getTimeInMillis ();

        X509V3CertificateGenerator certGen = new X509V3CertificateGenerator ();
        X500Principal dnName = new X500Principal ("CN=" + clientId);

        certGen.setSerialNumber (BigInteger.valueOf (current));
        certGen.setSubjectDN (dnName);
        certGen.setIssuerDN (dnName);
        certGen.setNotBefore (new Date (current));
        certGen.setNotAfter (new Date (naf));
        certGen.setPublicKey (keyPair.getPublic ());
        certGen.setSignatureAlgorithm (SIGNATURE_ALGORITHM);

        X509Certificate cert = certGen.generate (keyPair.getPrivate (), PROVIDER);
        try (StringWriter writer = new StringWriter (); PEMWriter pemWriter = new PEMWriter (writer);) {
            pemWriter.writeObject (cert);
            pemWriter.flush ();
            return writer.toString ();
        }
    }

    public static Key getKeyFromString (String encodedString) {

        String realPK = encodedString
                .replaceAll ("\\s", "")
                .replace ("-----BEGINRSAPRIVATEKEY-----", "")
                .replace ("-----ENDRSAPRIVATEKEY-----", "");

        byte[] b1 = Base64.decodeBase64 (realPK);
        PKCS8EncodedKeySpec spec = new PKCS8EncodedKeySpec (b1);
        try {
            KeyFactory kf = KeyFactory.getInstance ("RSA");
            return kf.generatePrivate (spec);
        } catch (InvalidKeySpecException | NoSuchAlgorithmException e) {
        }
        return null;
    }
}
