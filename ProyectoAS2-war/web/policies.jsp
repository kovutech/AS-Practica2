<%@page import="com.as.practica2.singleton.StadisticsBean"%>
<%@page import="com.as.practica2.singleton.LogBean"%>

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              <%-- 
Document   : clientFile
Created on : 25-feb-2018, 11:22:57
Author     : Jorge
--%>
<%@page import="com.as.practica2.stateful.PolicyBean"%>
<%@page import="com.as.practica2.stateless.ClientLevel"%>
<%@page import="com.as.practica2.stateless.CalculateDniLetter"%>
<%@page import="com.as.practica2.object.Policy"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Map"%>
<%@page import="javax.naming.NamingException"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("user") == null) {
        RequestDispatcher r = request.getRequestDispatcher("index.jsp");
        r.forward(request, response);
    }

    List<String> clientData = (List<String>) session.getAttribute("clientData");

    if (session.getAttribute("policyList") == null) {
        try {
            PolicyBean clientStatBean = InitialContext.doLookup("java:global/ProyectoAS2/ProyectoAS2-ejb/PolicyBean");
            session.setAttribute("policyList", clientStatBean);
            PolicyBean policyList = (PolicyBean) session.getAttribute("policyList");

            policyList.addPolicy(clientData.get(2), new Policy("AUT35263492", "Autos", "01/01/2018", "01/01/2019", "Semestral", "125.50"), (String) session.getAttribute("user"));
            policyList.addPolicy(clientData.get(2), new Policy("VID3748596", "Vida", "01/06/2018", "01/08/2018", "Mensual", "51.30"), (String) session.getAttribute("user"));
            policyList.addPolicy(clientData.get(2), new Policy("DEC3748596", "Decesos", "01/09/2018", "01/09/2019", "Anual", "78"), (String) session.getAttribute("user"));
        } catch (NamingException ex) {
        }
    }

    LogBean logBean = InitialContext.doLookup("java:global/ProyectoAS2/ProyectoAS2-ejb/LogBean");
    logBean.addFuntion("policies.jsp");

    StadisticsBean estadisticasBean = InitialContext.doLookup("java:global/ProyectoAS2/ProyectoAS2-ejb/StadisticsBean");
    estadisticasBean.addPage("policies.jsp");

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style.css">
        <title>Torniquete seguros s.a.</title>
    </head>
    <body>
        <jsp:include page="headerA.jsp"/>

        <FORM action='FrontController' method='post'>
            <TABLE border=1 class='center'>
                <TR><TD colspan='7'>AÑADIR PÓLIZA</TD></TR>
                <TR><TH><B>Identificación</B></TH><TH><B>Tipo</B></TH><TH><B>Desde</B></TH><TH><B>Hasta</B></TH><TH><B>Forma de pago</B></TH><TH colspan='2'><B>Importe</B></TH></TR>
                <TR>
                <INPUT type='hidden' name='command' value='Policies'>
                <INPUT type='hidden' name='addPolicy' value='1'>
                <TD><INPUT type='text' name='id' value='' placeholder='Identificación' ></TD>
                <TD> <select name="type">
                        <option value="Accidentes">Accidentes</option>
                        <option value="Ahorro">Ahorro</option>
                        <option value="Autos">Autos</option>
                        <option value="Decesos">Decesos</option>
                        <option value="Embarcaciones">Embarcaciones</option>
                        <option value="Hogar">Hogar</option>
                        <option value="Motos">Motos</option>
                        <option value="Salud">Salud</option>
                        <option value="Viajes">Viajes</option>
                        <option value="Vida">Vida</option>
                    </select> </TD>
                <TD><INPUT type='date' name='from' value='' placeholder='Desde'></TD>
                <TD><INPUT type='date' name='to' value='' placeholder='Hasta'></TD>
                <TD> <select name="payRange">
                        <option value="Mensual">Mensual</option>
                        <option value="Semestral">Semestral</option>
                        <option value="Anual">Anual</option>
                    </select> </TD>
                <TD><INPUT type='number' name='price' value='' placeholder='Importe' step='any' min='0'></TD>
                <TD><INPUT type='submit' value='Añadir' class='botonTable'></TD>
                </TR>
            </TABLE>
        </FORM>
        <br>
        <br>
        <%            ClientLevel clientLevel = InitialContext.doLookup("java:global/ProyectoAS2/ProyectoAS2-ejb/ClientLevel");
            CalculateDniLetter calculateDniLetter = InitialContext.doLookup("java:global/ProyectoAS2/ProyectoAS2-ejb/CalculateDniLetter");

            PolicyBean aux = (PolicyBean) session.getAttribute("policyList");

            List<Policy> policies = new ArrayList<Policy>();
            policies = aux.getPolicyList(clientData.get(2), (String) session.getAttribute("user"));
            session.setAttribute("policies", policies);

            out.print("<h2>Cliente: " + clientData.get(0) + " " + clientData.get(1) + " - Identificador: " + clientData.get(2) + calculateDniLetter.getDniLetter(clientData.get(2), (String) session.getAttribute("user")) + " - Nivel de cliente: " + clientLevel.getClientLevel(policies.size(), (String) session.getAttribute("user")) + "</h2>");

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
                out.print("<TD><FORM action='FrontController'><INPUT type='hidden' name='command' value='Receipts'><INPUT type='hidden' name='idPolicy' value=" + elem.getId() + "><INPUT type='submit' value='Recibo' class='botonTable'></FORM>");
                out.print("</TR>");
            }
            out.print("</TABLE><BR>");
        %>

        <FORM action='FrontController'>
            <INPUT type='hidden' name='command' value='SellRecommendation'>
            <INPUT type='submit' value='Recomendacion de venta' class='boton'>
        </FORM>    
        <br>
        <FORM action='FrontController'>
            <INPUT type='hidden' name='command' value='Main'>
            <INPUT type='submit' value='Volver' class='boton'>
        </FORM>

        <jsp:include page="footer.jsp"/>
    </body>
</html>