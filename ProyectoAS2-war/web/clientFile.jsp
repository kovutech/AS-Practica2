<%-- 
    Document   : clientFile
    Created on : 25-feb-2018, 11:22:57
    Author     : Jorge
--%>

<%@page import="javax.naming.InitialContext"%>
<%@page import="com.as.practica2.ClientLevel"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="frontController.Policy"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%     if (session.getAttribute("user") == null) {
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
            ClientLevel clientLevel = InitialContext.doLookup("java:global/ProyectoAS2/ProyectoAS2-ejb/ClientLevel");
            
            out.print("<FORM action='FrontController'>");
            out.print("<INPUT type='hidden' name='command' value='Logout'>");
            out.print("<INPUT type='submit' value='Cerrar sesión' class='botonLogout'>");
            out.print("</FORM><BR>");

            String user = (String) session.getAttribute("user");
            out.print("<h3>Agente: " + user + "</h3>");

            List<String> clientData = new ArrayList<String>();
            clientData.add(request.getParameter("nombre"));
            clientData.add(request.getParameter("apellido"));
            clientData.add(request.getParameter("dni"));
            session.setAttribute("clientData", clientData);
            List<Policy> policies = new ArrayList<Policy>();
            policies.add(new Policy("72947837", "Autos", "01/05/2017", "01/05/2018", "Semestral", 235.40f));
            policies.add(new Policy("89729473", "Decesos", "01/03/2018", "01/05/2058", "Mensual", 89.53f));
            policies.add(new Policy("11209334", "Autos", "01/05/2017", "01/05/2018", "Anual", 435.40f));
            policies.add(new Policy("43636273", "Vida", "01/08/2017", "01/05/2018", "Trimestral", 235.46f));
            policies.add(new Policy("19172387", "Ahorro", "01/12/2016", "01/05/2018", "Anual", 2235.84f));
            policies.add(new Policy("48390582", "Embarcaciones", "01/05/2014", "01/05/2018", "Semestral", 235.53f));
            session.setAttribute("policies", policies);
            out.print("<h2>Cliente: " + request.getParameter("nombre") + " " + request.getParameter("apellido") + " - Identificador: " + request.getParameter("dni") + " - Nivel de cliente: " + clientLevel.getClientLevel(policies.size()) + "</h2>");

            out.print("<TABLE border=1 class='center'>");
            out.print("<TR><TD colspan='7'>LISTADO DE PÓLIZAS</TD></TR>");
            out.print("<TR><TD>Nº póliza</TD><TD>Tipo</TD><TD>F. efecto</TD><TD>F. vencimiento</TD><TD>Forma de pago</TD><TD>Importe</TD><TD>Recibos</TD></TR>");
            for (Policy elem : policies) {
                out.print("<TR>");
                out.print("<TD>" + elem.getId() + "</TD>");
                out.print("<TD>" + elem.getType() + "</TD>");
                out.print("<TD>" + elem.getEffectDate() + "</TD>");
                out.print("<TD>" + elem.getDueDate() + "</TD>");
                out.print("<TD>" + elem.getPaymentMethod() + "</TD>");
                out.print("<TD>" + elem.getAmount() + " €</TD>");
                out.print("<TD><FORM action='FrontController'><INPUT type='hidden' name='command' value='Receipt'><INPUT type='submit' value='Recibo' class='botonTable'></FORM>");
                out.print("</TR>");
            }
            out.print("</TABLE><BR>");
            out.print("<FORM action='FrontController'><INPUT type='hidden' name='command' value='SellRecomendation'><INPUT type='submit' value='Recomendacion de venta' class='boton'></FORM>");
        %>
    </body>
</html>