package br.com.fatec.services;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import br.com.fatec.models.Grupo;
import br.com.fatec.persistence.GrupoDAO;

public class GrupoService {
	private GrupoDAO grupoDAO;

	public GrupoService(GrupoDAO grupoDAO) {
		super();
		this.grupoDAO = grupoDAO;
	}

	public List<Grupo> listarGrupos() {
		try {
			var grupoA = this.grupoDAO.find("A");
			var grupoB = this.grupoDAO.find("B");
			var grupoC = this.grupoDAO.find("C");
			var grupoD = this.grupoDAO.find("D");
			return Arrays.asList(grupoA, grupoB, grupoC, grupoD)
					.stream()
					.filter(talvezGrupo -> talvezGrupo.isPresent())
					.map(talvezGrupo -> talvezGrupo.get())
					.collect(Collectors.toList());
		} catch (Exception exception) {
			return new ArrayList<Grupo>();
		}
	}
	
	public void sortearGrupos() throws SQLException {
		this.grupoDAO.sort();
	}
}
