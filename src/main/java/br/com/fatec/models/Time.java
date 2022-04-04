package br.com.fatec.models;

public class Time {
	private int codigo;
	private String nome;
	private String cidade;
	private String estadio;
	
	public Time(int codigo, String nome, String cidade, String estadio) {
		super();
		this.codigo = codigo;
		this.nome = nome;
		this.cidade = cidade;
		this.estadio = estadio;
	}

	public int getCodigo() {
		return codigo;
	}

	public String getNome() {
		return nome;
	}

	public String getCidade() {
		return cidade;
	}

	public String getEstadio() {
		return estadio;
	}
}
