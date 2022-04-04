package br.com.fatec.persistence;

import java.sql.SQLException;

public class JogoDAOFactory {
	public static JogoDAO create() throws ClassNotFoundException, SQLException {
		return new SQLServerJogoDAO(ConnectionFactory.getConnection());
	}
}
