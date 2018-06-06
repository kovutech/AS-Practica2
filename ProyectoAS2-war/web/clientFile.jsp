<%@page import="com.as.practica2.CalculateDniLetter"%>
<%@page import="java.util.Map"%>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              <%-- 
Document   : clientFile
Created on : 25-feb-2018, 11:22:57
Author     : Jorge
--%>
<%@page import="com.as.practica2.Policy"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="com.as.practica2.ClientLevel"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="com.as.practica2.PolicyBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("user") == null) {
        RequestDispatcher r = request.getRequestDispatcher("index.jsp");
        r.forward(request, response);
    }

    if (session.getAttribute("policyList") == null) {
        try {
            PolicyBean clientStatBean = InitialContext.doLookup("java:global/ProyectoAS2/ProyectoAS2-ejb/PolicyBean");
            session.setAttribute("policyList", clientStatBean);
            PolicyBean policyList = (PolicyBean) session.getAttribute("policyList");

            policyList.addPolicy(request.getParameter("dni"), new Policy("AUT35263492", "Autos", "01/01/2018", "01/01/2019", "Semestral", "125.50"));
            policyList.addPolicy(request.getParameter("dni"), new Policy("VID3748596", "Vida", "01/06/2018", "01/08/2018", "Mensual", "51.30"));
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
        <jsp:include page="header.jsp"/>

        <FORM action='FrontController' method='post'>
            <TABLE border=1 class='center'>
                <TR><TD colspan=''>AÑADIR PÓLIZA</TD></TR>
                <TR><TH><B>Identificación</B></TH><TH><B>Tipo</B></TH><TH><B>Desde</B></TH><TH><B>Hasta</B></TH><TH><B>Forma de pago</B></TH><TH><B>Importe</B></TH></TR>
                <TR>
                <INPUT type='hidden' name='command' value='ClientFile'>
                <INPUT type='hidden' name='addPolicy' value='1'>
                <TD><INPUT type='text' name='id' value='' placeholder='Identificación' ></TD>
                <TD><INPUT type='text' name='type' value='' placeholder='Tipo'></TD>
                <TD><INPUT type='text' name='from' value='' placeholder='Desde'></TD>
                <TD><INPUT type='text' name='to' value='' placeholder='Hasta'></TD>
                <TD><INPUT type='text' name='payRange' value='' placeholder='Forma de pago'></TD>
                <TD><INPUT type='text' name='price' value='' placeholder='Importe'></TD>
                <TD><INPUT type='submit' value='Añadir' class='botonTable'></TD>
                </TR>
            </TABLE>
        </FORM>
        <br>
        <br>
        <%            
            ClientLevel clientLevel = InitialContext.doLookup("java:global/ProyectoAS2/ProyectoAS2-ejb/ClientLevel");
            //CalculateDniLetter calculateDniLetter = InitialContext.doLookup("java:global/ProyectoAS2/ProyectoAS2-ejb/CalculateDniLetter");

            List<String> clientData = new ArrayList<String>();
            clientData.add(request.getParameter("nombre"));
            clientData.add(request.getParameter("apellido"));
            clientData.add(request.getParameter("dni"));
            session.setAttribute("clientData", clientData);
            PolicyBean aux = (PolicyBean) session.getAttribute("policyList");
            List<Policy> policies = aux.getPolicyList(request.getParameter("dni"));
            session.setAttribute("policies", policies);
            //out.print("<h2>Cliente: " + request.getParameter("nombre") + " " + request.getParameter("apellido") + " - Identificador: " + request.getParameter("dni") + " - Nivel de cliente: " + clientLevel.getClientLevel(policies.size()) + "</h2>");
            //out.print("<h2>Cliente: " + clientData.get(0) + " " + clientData.get(1) + " - Identificador: " + clientData.get(2) + calculateDniLetter.getDniLetter(clientData.get(2)) + " - Nivel de cliente: " + clientLevel.getClientLevel(policies.size()) + "</h2>");
            out.print("<h2>Cliente: " + clientData.get(0) + " " + clientData.get(1) + " - Identificador: " + clientData.get(2) + " - Nivel de cliente: " + clientLevel.getClientLevel(policies.size()) + "</h2>");
            out.print("<TABLE border=1 class='center'>");
            out.print("<TR><TD colspan='7'>LISTADO DE PÓLIZAS</TD></TR>");
            out.print("<TR><TD>Nº póliza</TD><TD>Tipo</TD><TD>F. efecto</TD><TD>F. vencimiento</TD><TD>Forma de pago</TD><TD>Importe</TD><TD>Recibos</TD></TR>");
            for (Policy elem : policies) {
                out.print("<TR>");
                out.print("<TD>" + elem.getId() + "</TD>");
                out.print("<TD>" + elem.getType() + "</TD>");
                out.print("<TD>" + elem.getFrom() + "</TD>");
                out.print("<TD>" + elem.getTo() + "</TD>");
                out.print("<TD>" + elem.getPayRange() + "</TD>");
                out.print("<TD>" + elem.getPrice() + " €</TD>");
                out.print("<TD><FORM action='FrontController'><INPUT type='hidden' name='command' value='Receipt'><INPUT type='submit' value='Recibo' class='botonTable'></FORM>");
                out.print("</TR>");
            }
            out.print("</TABLE><BR>");
            out.print("<FORM action='FrontController'><INPUT type='hidden' name='command' value='SellRecomendation'><INPUT type='submit' value='Recomendacion de venta' class='boton'></FORM>");
        %>
        <jsp:include page="footer.jsp"/>
    </body>
</html>