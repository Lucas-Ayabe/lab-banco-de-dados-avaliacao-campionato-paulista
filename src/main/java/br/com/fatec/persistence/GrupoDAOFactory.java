package br.com.fatec.persistence;

import java.sql.SQLException;

public class GrupoDAOFactory {
	public static GrupoDAO create() throws ClassNotFoundException, SQLException {
		return new SQLServerGrupoDAO(ConnectionFactory.getConnection());
	}
}
