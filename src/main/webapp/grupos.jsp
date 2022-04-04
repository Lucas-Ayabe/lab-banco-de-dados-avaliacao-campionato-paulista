<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Grupos</title>
        <link
            rel="stylesheet"
            href="./css/pico.min.css"
        />
        <link
            rel="stylesheet"
            href="./css/styles.css"
        />
    </head>
    <body>
    	<header class="container pb-0">
    		<nav>
    			 <ul>
    			 	<li class="brand">Campeonato Paulista</li>
				    <li><a href="/CampeonatoPaulista/grupos">Grupos</a></li>
				    <li><a href="/CampeonatoPaulista/jogos">Jogos</a></li>
				  </ul>
    		</nav>
    		<hr />
    		<br>
    		<div class="grid align-start">
    			<h1>Grupos</h1>
	    		<div></div>
	    		<form method="POST" action="/CampeonatoPaulista/grupos">
	    			<button>Sortear Grupos</button>
	    		</form>
    		</div>
    	</header>
    	<main class="container pt-0">
			<c:choose>
				<c:when test="${!grupos.isEmpty()}">
					<c:forEach var="grupo" items="${grupos}">
						<figure>
							<table>
								<caption>Grupo <c:out value="${grupo.getNome()}"></c:out></caption>
								<thead>
									<tr>
										<th scope="col">Codigo</th>
										<th scope="col">Time</th>
										<th scope="col">Cidade</th>
										<th scope="col">Estadio</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="time" items="${grupo.getTimes()}">
										<tr>
											<td><c:out value="${time.getCodigo()}"></c:out></td>
											<td><c:out value="${time.getNome()}"></c:out></td>
											<td><c:out value="${time.getCidade()}"></c:out></td>
											<td><c:out value="${time.getEstadio()}"></c:out></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</figure>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<p>Nenhum grupo sorteado ainda, clique no botão acima para gerar os grupos.</p>
				</c:otherwise>
			</c:choose>
		</main>
    </body>
</html>
