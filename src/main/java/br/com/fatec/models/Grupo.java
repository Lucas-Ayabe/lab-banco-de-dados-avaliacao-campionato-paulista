package br.com.fatec.models;

import java.util.ArrayList;
import java.util.List;

public class Grupo {
	private int codigo;
	private String nome;
	private List<Time> times;
	
	public Grupo(int codigo, String nome, List<Time> times) {
		super();
		this.codigo = codigo;
		this.nome = nome;
		this.times = times;
	}
	
	public Grupo(int codigo, String nome) {
		this(codigo, nome, new ArrayList<Time>());
	}
	
	public Grupo adicionarTime(Time time) {
		this.times.add(time);
		return this;
	}
	
	public int getCodigo() {
		return codigo;
	}
	public String getNome() {
		return nome;
	}
	public List<Time> getTimes() {
		return times;
	}
	
	
}
