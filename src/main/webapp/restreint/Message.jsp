<jsp:useBean id="GestionMessages" scope="application"
	class="com.modele.GestionMessages" />
<%@page import="com.modele.Message"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html5">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta HTTP-EQUIV="Refresh" CONTENT="5">
	<title>Message</title>
</head>
<body>
	<jsp:include page="Stockage.jsp"/>
 
	<jsp:forward page="Affichage.jsp"/>



</body>
</html>