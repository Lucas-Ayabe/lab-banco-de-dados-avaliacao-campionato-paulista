package br.com.fatec.models;

import java.time.LocalDate;

public class Jogo {
	private int codigo;
	private String timeA;
	private String timeB;
	private int golsDoTimeA;
	private int golsDoTimeB;
	private LocalDate dataDoJogo;
	
	public Jogo(int codigo, String timeA, String timeB, int golsDoTimeA, int golsDoTimeB, LocalDate dataDoJogo) {
		super();
		this.codigo = codigo;
		this.timeA = timeA;
		this.timeB = timeB;
		this.golsDoTimeA = golsDoTimeA;
		this.golsDoTimeB = golsDoTimeB;
		this.dataDoJogo = dataDoJogo;
	}

	public int getCodigo() {
		return codigo;
	}

	public String getNomeDoTimeA() {
		return timeA;
	}

	public String getNomeDoTimeB() {
		return timeB;
	}

	public int getGolsDoTimeA() {
		return golsDoTimeA;
	}

	public int getGolsDoTimeB() {
		return golsDoTimeB;
	}

	public LocalDate getDataDoJogo() {
		return dataDoJogo;
	}
}
