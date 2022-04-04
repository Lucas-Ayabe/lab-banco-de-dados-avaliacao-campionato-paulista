package br.com.fatec.services;

import java.sql.SQLException;

import br.com.fatec.persistence.GrupoDAOFactory;

public class GrupoServiceFactory {
	public static GrupoService create() throws ClassNotFoundException, SQLException {
		return new GrupoService(GrupoDAOFactory.create());
	}
}
