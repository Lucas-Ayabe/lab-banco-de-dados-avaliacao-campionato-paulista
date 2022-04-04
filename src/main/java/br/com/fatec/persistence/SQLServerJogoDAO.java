package br.com.fatec.persistence;

import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import br.com.fatec.models.Jogo;

public class SQLServerJogoDAO implements JogoDAO {
	private Connection connection;

	public SQLServerJogoDAO(Connection connection) {
		this.connection = connection;
	}

	@Override
	public List<Jogo> findAllByDate(String date) throws SQLException {
		var dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-d");
		var query = "{CALL sp_pesquisar_rodada(?)}";
		var call = this.connection.prepareCall(query);
		call.setString(1, date);
		call.execute();
		var result = call.getResultSet();
		var rows = new ArrayList<Jogo>();
		while (result.next()) {
			rows.add(
				new Jogo(
					result.getInt("CodigoJogo"),
					result.getString("NomeTimeA"),
					result.getString("NomeTimeB"),
					result.getInt("GolsTimeA"),
					result.getInt("GolsTimeB"),
					LocalDate.parse(result
						.getString("DataDoJogo"), dateFormatter)
				)
			);
		}
		
		return rows;
	}

	@Override
	public void sort() throws SQLException {
		this.connection.prepareCall("CALL sp_inserir_grupos").execute();
		this.connection.prepareCall("CALL sp_inserir_jogos").execute();
	}
}
