package br.com.fatec.persistence;

import java.sql.SQLException;
import java.util.Optional;

import br.com.fatec.models.Grupo;

public interface GrupoDAO {
	public Optional<Grupo> find(String group) throws SQLException;
	public void sort() throws SQLException;
}
