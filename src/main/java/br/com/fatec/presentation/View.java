package br.com.fatec.presentation;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class View {
	private String resource;
	private Map<String, Object> data;
	
	public View(String resource) {
		this.resource = resource;
		this.data = new HashMap<String, Object>();
	}
	
	public View with(String key, Object value) {
		this.data.put(key, value);
		return this;
	}
	
	public void renderIn(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		var view = request.getRequestDispatcher(resource);
		this.data.forEach((key, value) -> {
			request.setAttribute(key, value);
		});
		
		view.forward(request, response);
	}
}
