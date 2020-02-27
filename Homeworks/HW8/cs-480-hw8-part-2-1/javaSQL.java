
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;


public class javaSQL
{
    // code taken from https://dev.mysql.com/doc/connector-j/8.0/en/connector-j-usagenotes-connect-drivermanager.html
    // 
    public static void main(String[] args) {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        ResultSetMetaData rsmd = null;
        
        try {
            // The newInstance() call is a work around for some
            // broken Java implementations

            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        } catch (Exception ex) {
            ex.printStackTrace();
            // handle the error
        }

        try {
            conn =
                    DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/Bank"+
                            "?user=root");
//                            "jdbc:mysql://mysql.cs.uic.edu:3306?" +
//                            "user=student&password=CS480FA2019!");

            stmt = conn.createStatement();
            //stmt.execute("USE Bank;");
            //rs = stmt.executeQuery("SHOW Databases;");
            //rs = stmt.executeQuery("SHOW Tables;");
            //rs = stmt.executeQuery("SELECT * FROM Person LIMIT 10;");
            //rs = stmt.executeQuery("DESCRIBE Person;");
            
            rs = stmt.executeQuery("SELECT * FROM Account LIMIT 10;");

            // or alternatively, if you don't know ahead of time that
            // the query will be a SELECT...
            // For example you might use stmt.execute to insert a value
            // stmt.execute("INSERT INTO Table Values(1,1);")) 
            // rs = stmt.getResultSet();

            if (rs!=null){
                rsmd = rs.getMetaData();
                int numColumns = rsmd.getColumnCount();
                for(int i = 1; i<=numColumns; ++i)
                {
                    System.out.print(rsmd.getColumnLabel(i)+"\t");
                }
                System.out.println();
                while(rs.next()) // loop through all rows
                { // Extract fields by index or by name
                    for(int i = 1; i<=numColumns; ++i)
                    {
                        System.out.print(rs.getString(i)+"\t");
                    }
                    System.out.println(); 
                }
            }
        }
        catch (SQLException ex){
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
        finally {
            // it is a good idea to release
            // resources in a finally{} block
            // in reverse-order of their creation
            // if they are no-longer needed

            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException sqlEx) {
                } // ignore

                rs = null;
            }

            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException sqlEx) {
                } // ignore

                stmt = null;
            }
        }
   }
}

