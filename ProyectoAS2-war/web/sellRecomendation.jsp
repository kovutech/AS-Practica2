<%-- 
    Document   : SellRecomendation
    Created on : 26-feb-2018, 18:13:45
    Author     : Jorge
--%>

<%@page import="com.as.practica2.SellRecomendation"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.ejb.EJB"%>
<%@page import="java.lang.String"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="frontController.Policy"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("user") == null) {
        RequestDispatcher r = request.getRequestDispatcher("index.jsp");
        r.forward(request, response);
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style.css">
        <title>Torniquete seguros s.a.</title>
    </head>
    <body>
        <h1 class="title">Torniquete seguros s.a.</h1>
        <%
            out.print("<FORM action='FrontController' >");
            out.print("<INPUT type='hidden' name='command' value='Logout'>");
            out.print("<INPUT type='submit' value='Cerrar sesión' class='botonLogout'>");
            out.print("</FORM><BR>");

            String user = (String) session.getAttribute("user");
            List<String> clientData = new ArrayList<String>();
            clientData = (ArrayList) session.getAttribute("clientData");
            out.print("<h3>Agente: " + user + "</h3>");
            out.print("<h2>Cliente: " + clientData.get(0) + " " + clientData.get(1) + " - Identificador: " + clientData.get(2) + "</h2>");

            SellRecomendation sellRecomendation = InitialContext.doLookup("java:global/ProyectoAS2/ProyectoAS2-ejb/SellRecomendation");

            List<Policy> policies = (ArrayList) session.getAttribute("policies");
            List<String> stringPolicies = new ArrayList<String>();

            for (Policy elem : policies) {
                stringPolicies.add(elem.getType());
            }

            List<String> auxTypesInsurances = sellRecomendation.getRecommendatios(stringPolicies);

            out.print("<div class='textAux'>Al cliente se le deberían de ofrecer los siguientes productos.<div><BR>");

            out.print("<TABLE class='insurance'>");
            for (String elem : auxTypesInsurances) {
                out.print("<TR>");
                out.print("<TD>" + elem + "</TD>");
                out.print("<TD><img src='./img/" + elem + ".png' height='75' width='75'></TD>");
                out.print("</TR>");
            }
        %>
    </body>
</html>
