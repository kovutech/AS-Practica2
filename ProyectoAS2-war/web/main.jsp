<%-- 
    Document   : main
    Created on : 24-feb-2018, 16:51:22
    Author     : Jorge
--%>

<%@page import="com.as.practica2.Client"%>
<%@page import="java.util.ResourceBundle.Control"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="com.as.practica2.ClientBean"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="com.as.practica2.CalculateDniLetter"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("user") == null) {
        RequestDispatcher r = request.getRequestDispatcher("index.jsp");
        r.forward(request, response);
    }

    if (session.getAttribute("clientList") == null) {
        try {
            ClientBean clientStatBean = InitialContext.doLookup("java:global/ProyectoAS2/ProyectoAS2-ejb/ClientBean");
            session.setAttribute("clientList", clientStatBean);
        } catch (NamingException ex) {
        }
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
            CalculateDniLetter calculateDniLetter = InitialContext.doLookup("java:global/ProyectoAS2/ProyectoAS2-ejb/CalculateDniLetter");
            out.print("<FORM action='FrontController'>");
            out.print("<INPUT type='hidden' name='command' value='Logout'>");
            out.print("<INPUT type='submit' value='Cerrar sesión' class='botonLogout'>");
            out.print("</FORM><BR>");

            String user = (String) session.getAttribute("user");
            out.print("<h3>Agente: " + user + "</h3>");

            ClientBean clientList = (ClientBean) session.getAttribute("clientList");

            clientList.addClient(new Client("00000000", "Jorge", "Fernandez", "555-555-555"));
            clientList.addClient(new Client("11111111", "Pedro", "Cabrera", "555-555-444"));

            /*List<Client> clientes = new ArrayList<Client>();
            clientes.add(new Client("00000000", "Jorge", "Fernandez", "555-555-555"));
            clientes.add(new Client("11111111", "Pedro", "Cabrera", "555-555-444"));
            clientes.add(new Client("22222222", "Rita", "Medina", "555-555-523"));
            clientes.add(new Client("33333333", "Sandra", "Hernandez", "555-555-123"));
            clientes.add(new Client("44444444", "Marta", "Gonzalez", "555-555-654"));
             */
            out.print("<TABLE border=1 class='center'>");
            out.print("<TR><TD colspan='5'>LISTADO DE CLIENTES</TD></TR>");
            out.print("<TR><TH><B>Dni</B></TH><TH><B>Nombre</B></TH><TH><B>Apellido</B></TH><TH><B>Teléfono</B></TH><TH><B>Ficha</B></TH></TR>");
           
            for (Client elem : clientList.getClientList()) {
                out.print("<TR>");
                out.print("<TD>" + elem.getId() + " " + calculateDniLetter.getDniLetter(elem.getId()) + "</TD>");
                out.print("<TD>" + elem.getName() + "</TD>");
                out.print("<TD>" + elem.getSurame() + "</TD>");
                out.print("<TD>" + elem.getTelephone() + "</TD>");
                out.print("<TD><FORM action='FrontController' method='post'>");
                out.print("<INPUT type='hidden' name='command' value='ClientFile'>");
                out.print("<INPUT type='hidden' name='dni' value='" + elem.getId() + "'>");
                out.print("<INPUT type='hidden' name='nombre' value='" + elem.getName() + "'>");
                out.print("<INPUT type='hidden' name='apellido' value='" + elem.getSurame() + "'>");
                out.print("<INPUT type='hidden' name='telefono' value='" + elem.getTelephone() + "'>");
                out.print("<INPUT type='submit' value='Acceder' class='botonTable'></FORM>");
                out.print("</TR>");
            }
            out.print("</TABLE>");
        %>
    </body>
</html>

