package in.smartcampus;
import java.security.*;import java.util.*;import javax.crypto.SecretKeyFactory;import javax.crypto.spec.PBEKeySpec;
public final class Security {
 private Security(){}
 public static String hash(String password) throws Exception { byte[] salt=new byte[16]; SecureRandom.getInstanceStrong().nextBytes(salt); byte[] out=derive(password.toCharArray(),salt,120000); return Base64.getEncoder().encodeToString(salt)+":"+Base64.getEncoder().encodeToString(out); }
 public static boolean verify(String password,String stored) throws Exception { String[] p=stored.split(":"); if(p.length!=2)return false; byte[] salt=Base64.getDecoder().decode(p[0]); byte[] expected=Base64.getDecoder().decode(p[1]); return MessageDigest.isEqual(expected,derive(password.toCharArray(),salt,120000)); }
 private static byte[] derive(char[] p,byte[] s,int rounds)throws Exception { PBEKeySpec spec=new PBEKeySpec(p,s,rounds,256); try{return SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256").generateSecret(spec).getEncoded();}finally{spec.clearPassword();} }
}