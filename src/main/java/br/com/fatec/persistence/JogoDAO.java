package br.com.fatec.persistence;

import java.sql.SQLException;
import java.util.List;

import br.com.fatec.models.Jogo;

public interface JogoDAO {
	public List<Jogo> findAllByDate(String date) throws SQLException;
	public void sort() throws SQLException;
}
