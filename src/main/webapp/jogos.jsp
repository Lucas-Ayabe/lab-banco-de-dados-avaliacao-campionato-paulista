<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Jogos</title>
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
    			<h1>Jogos</h1>
    			<div></div>
	    		<form method="POST" action="/CampeonatoPaulista/jogos">
	    			<button>Sortear Jogos</button>
	    		</form>
    		</div>
    	</header>
    	<main class="container pt-0">
    		<form class="search" action="/CampeonatoPaulista/jogos">
    			<label>
    				<span>Pesquisar jogos por data</span>
	    			<input type="date" name="dataDoJogo" />
    			</label>
    			
    			<button>Pesquisar Jogos</button>
    		</form>

			<c:choose>
				<c:when test="${!jogos.isEmpty()}">
					<figure>
						<table>
							<caption>Jogos Encontrados</caption>
							<thead>
								<tr>
									<th scope="col">Codigo</th>
									<th scope="col">Time A</th>
									<th scope="col">Time B</th>
									<th scope="col">Gols do Time A</th>
									<th scope="col">Gols do Time B</th>
									<th scope="col">Data do jogo</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="jogo" items="${jogos}">
									<tr>
										<td><c:out value="${jogo.getCodigo()}"></c:out></td>
										<td><c:out value="${jogo.getNomeDoTimeA()}"></c:out></td>
										<td><c:out value="${jogo.getNomeDoTimeB()}"></c:out></td>
										<td><c:out value="${jogo.getGolsDoTimeA()}"></c:out></td>
										<td><c:out value="${jogo.getGolsDoTimeB()}"></c:out></td>
										<td><c:out value="${jogo.getDataDoJogo()}"></c:out></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</figure>
				</c:when>
				<c:otherwise>
					<p>Nenhum jogo encontrado, tente pesquisar utilizando o formulário acima.</p>
				</c:otherwise>
			</c:choose>
		</main>
    </body>
</html>
