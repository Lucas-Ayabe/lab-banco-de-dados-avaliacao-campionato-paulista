package br.com.fatec.persistence;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Optional;

import br.com.fatec.models.Time;
import br.com.fatec.models.Grupo;

public class SQLServerGrupoDAO implements GrupoDAO {
	private Connection connection;

	public SQLServerGrupoDAO(Connection connection) {
		this.connection = connection;
	}

	@Override
	public Optional<Grupo> find(String group) throws SQLException {
		var query = "SELECT * FROM v_grupos WHERE Grupo = ?";
		var stmt = this.connection.prepareStatement(query);
		stmt.setString(1, group);
		var result = stmt.executeQuery();
		result.next();

		if (result.getInt("Codigo") > 0) {
			var grupo = new Grupo(result.getInt("Codigo"), result.getString("Grupo"));
			do {
				grupo.adicionarTime(new Time(result.getInt("CodigoTime"), result.getString("Nome"),
						result.getString("Cidade"), result.getString("Estadio")));
			} while (result.next());
			
			return Optional.of(grupo);
		}

		return Optional.empty();
	}

	@Override
	public void sort() throws SQLException {
		this.connection.prepareCall("CALL sp_inserir_grupos").execute();
	}

}
