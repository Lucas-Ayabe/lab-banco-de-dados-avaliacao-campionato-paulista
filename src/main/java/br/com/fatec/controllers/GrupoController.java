package br.com.fatec.controllers;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.fatec.presentation.View;
import br.com.fatec.services.GrupoService;
import br.com.fatec.services.GrupoServiceFactory;

/**
 * Servlet implementation class GrupoController
 */
@WebServlet("/grupos")
public class GrupoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private GrupoService grupoService;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GrupoController() {
		super();

		try {
			this.grupoService = GrupoServiceFactory.create();
		} catch (Exception exception) {
			exception.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			var view = new View("grupos.jsp");
			view	
				.with("grupos", this.grupoService.listarGrupos())
				.renderIn(request, response);
		} catch (Exception exception) {
			exception.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			this.grupoService.sortearGrupos();
			doGet(request, response);
		} catch (SQLException exception) {
			exception.printStackTrace();
		}
	}

}
