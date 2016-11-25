<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.chat.modele.Utilitaire" %>
<jsp:useBean id="gestion" scope="application"
             class="com.chat.modele.ChatGestionService"/>
<jsp:useBean id="util" scope="application"
             class="com.chat.modele.Utilitaire"/>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<!DOCTYPE html5">
<html>
<head>
<!-- Encodage CSS BOOSTRAP et personalis� -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
<title>Affichage des messages</title>
</head>
<body class="body_display">

<%
    response.setIntHeader("Refresh", 3);
    String salon = (String) session.getAttribute("salon");

    String methode = request.getMethod();
    String nomCookie = "lastModifiedChatRoom";
    Cookie tmpCookie = Utilitaire.getCookie(request.getCookies(), nomCookie);

    int nbMessClient;
    int nbMessServeur;

    //gestion.ajouterMessage(new Message("Bob", "test")); //test

    //teste de l'existence du cookie, cr�ation si n�cessaire
    if (tmpCookie == null) {

        Cookie creation = new Cookie(nomCookie, "0");
        creation.setMaxAge(60);
        response.addCookie(creation);
        tmpCookie = creation;
    } else {
        if (tmpCookie.getMaxAge() == 0) {
            tmpCookie.setMaxAge(60);
        }

    }
    //teste la m�thode utilis�e
    if (methode.equalsIgnoreCase("get")) {

        //nb messages c�t� client
        nbMessClient = Integer.parseInt(tmpCookie.getValue());
        //nb messages c�t� serveur
        nbMessServeur = gestion.nombreMessage(salon);

        /*
		* Comparaison du nombre de messages, client/serveur.
		* Si < est vrai, alors on va chercher les nouveaux messages,
		* sinon on dit au client qu'il n'y a pas de nouveau contenu � r�cup�rer (204)
		*/

        if (gestion.nombreMessage(salon) != 0) {
            if (nbMessClient < nbMessServeur) {
                response.addCookie(new Cookie(nomCookie, "" + gestion.nombreMessage(salon)));
            } else if (nbMessClient == nbMessServeur) {
                response.setStatus(204);
            } else {
                Cookie creation = new Cookie(nomCookie, "0");
                creation.setMaxAge(60);
                response.addCookie(creation);
            }

        } else {
            Cookie creation = new Cookie(nomCookie, "0");
            creation.setMaxAge(60);
            response.addCookie(creation);
        }

    }
    //Un contenu va �tre ajout�
    else if (methode.equalsIgnoreCase("post")) {
        //response.setStatus(204);
    }
%>

<div class='panel panel-info'>
    <div class='panel-heading'><h3 class='panel-title'>Listes des messages</h3>
    </div>
    <div class='panel-body'><br>
        <c:choose>
            <c:when test="${not empty messages}">
                <c:forEach items="${messages}" var="message">
                    <div class='block_message'>
                        <h4 class='user_user'><i class='glyphicon glyphicon-user'></i> ${message.user} a dit :</h4>
                        <h5 class='message_user'>${message.contenu}</h5>
                        <div class='date_user'>${message.date}</div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <h4>Binevenue au salon ${salon} Dorenavant vous avez la possibilit� de discuter avec tous les
                    membres du salon </h4>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>