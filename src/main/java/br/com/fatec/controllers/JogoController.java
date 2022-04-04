package br.com.fatec.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.fatec.models.Jogo;
import br.com.fatec.persistence.JogoDAO;
import br.com.fatec.persistence.JogoDAOFactory;
import br.com.fatec.presentation.View;

/**
 * Servlet implementation class JogoController
 */
@WebServlet("/jogos")
public class JogoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private JogoDAO jogoDAO;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JogoController() {
        super();
        try {
			this.jogoDAO = JogoDAOFactory.create();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		var dataDoJogo = request.getParameter("dataDoJogo");
		var view = new View("jogos.jsp");
		List<Jogo> jogos = new ArrayList<Jogo>();
		
		if (dataDoJogo != null) {
			try {
				jogos = this.jogoDAO.findAllByDate(dataDoJogo);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		view.with("jogos", jogos).renderIn(request, response);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			this.jogoDAO.sort();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		doGet(request, response);
	}
}
