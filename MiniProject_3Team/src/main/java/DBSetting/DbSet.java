package DBSetting;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbSet {
    static String vURL = "jdbc:oracle:thin:@localhost:1521:XE";
    static String vID = "hr";
    static String vPWD = "hr";
    //static String vID = "miniproject3team";
    //static String vPWD = "1234";
    

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(vURL, vID, vPWD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    } 

}
