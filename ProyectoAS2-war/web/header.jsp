<%-- 
    Document   : header
    Created on : 04-jun-2018, 18:59:48
    Author     : Jorge
--%>

<%@page import="javax.naming.InitialContext"%>
<%@page import="com.as.practica2.CalculateDniLetter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Torniquete Seguros s.a.</title>
    </head>
    <body>
        <h1 class="title">Torniquete seguros s.a.</h1>
        <%
            out.print("<FORM action='FrontController'>");
            out.print("<INPUT type='hidden' name='command' value='Logout'>");
            out.print("<INPUT type='submit' value='Cerrar sesión' class='botonLogout'>");
            out.print("</FORM><BR>");

            String user = (String) session.getAttribute("user");
            out.print("<h3>Agente: " + user + "</h3>");
        %>
    </body>
</html>