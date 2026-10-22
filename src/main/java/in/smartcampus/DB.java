package in.smartcampus;
import java.sql.*;
public final class DB {
 private DB() {}
 public static Connection get() throws SQLException {
  String url=System.getenv().getOrDefault("SC_DB_URL","jdbc:mysql://localhost:3306/smart_campus?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true");
  String user=System.getenv().getOrDefault("SC_DB_USER","root");
  String pass=System.getenv().getOrDefault("SC_DB_PASSWORD","");
  return DriverManager.getConnection(url,user,pass);
 }
}