package br.com.fatec.persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {
	public static Connection getConnection() throws ClassNotFoundException, SQLException {
		String hostName = "192.168.15.12";
		String dbName = "CP";
		String user = "lucas";
		String password = "123456";

		Class.forName("net.sourceforge.jtds.jdbc.Driver");
		String connect = String.format("jdbc:jtds:sqlserver://%s:1433;databaseName=%s;user=%s;password=%s", hostName,
				dbName, user, password);
		return DriverManager.getConnection(connect);
	}
}
