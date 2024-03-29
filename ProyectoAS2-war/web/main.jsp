<%-- 
    Document   : main
    Created on : 24-feb-2018, 16:51:22
    Author     : Jorge
--%>

<%@page import="com.as.practica2.singleton.StadisticsBean"%>
<%@page import="com.as.practica2.singleton.LogBean"%>
<%@page import="com.as.practica2.stateful.UserBean"%>
<%@page import="com.as.practica2.stateful.ClientBean"%>
<%@page import="com.as.practica2.stateless.CalculateDniLetter"%>
<%@page import="com.as.practica2.object.Client"%>
<%@page import="java.util.ResourceBundle.Control"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
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
            ClientBean clientList = (ClientBean) session.getAttribute("clientList");

            clientList.addClient(new Client("00000000", "Jorge", "Fernandez", "555-555-555"), (String) session.getAttribute("user"));
            clientList.addClient(new Client("11111111", "Pedro", "Cabrera", "555-555-444"), (String) session.getAttribute("user"));
        } catch (NamingException ex) {
        }
    }

    LogBean logBean = InitialContext.doLookup("java:global/ProyectoAS2/ProyectoAS2-ejb/LogBean");
    logBean.addFuntion("main.jsp");

    StadisticsBean estadisticasBean = InitialContext.doLookup("java:global/ProyectoAS2/ProyectoAS2-ejb/StadisticsBean");
    estadisticasBean.addPage("main.jsp");
%>
<jsp:include page="headerA.jsp"/>
<FORM action='FrontController' method='post'>
    <TABLE border=1 class='center'>
        <TR><TD colspan='5'>AÑADIR CLIENTE</TD></TR>
        <TR><TH><B>Dni (sin letra)</B></TH><TH><B>Nombre</B></TH><TH><B>Apellido</B></TH><TH><B>Teléfono</B></TH><TH><B>Insertar</B></TH></TR>
        <TR>
        <INPUT type='hidden' name='command' value='Main'>
        <INPUT type='hidden' name='addClient' value='1'>
        <TD><INPUT type='text' pattern='\d{8}' name='dni' value='' placeholder='Dni' maxlength='8'></TD>
        <TD><INPUT type='text' name='nombre' value='' placeholder='Nombre'></TD>
        <TD><INPUT type='text' name='apellido' value='' placeholder='Apellido'></TD>
        <TD><INPUT type='text' pattern='\d{9}' name='telefono' value='' placeholder='Telefono' maxlength='9'></TD>
        <TD><INPUT type='submit' value='Añadir' class='botonTable'></TD>
        </TR>
    </TABLE>
</FORM>
<br>
<br>
<%            CalculateDniLetter calculateDniLetter = InitialContext.doLookup("java:global/ProyectoAS2/ProyectoAS2-ejb/CalculateDniLetter");
    ClientBean clientList = (ClientBean) session.getAttribute("clientList");

    out.print("<TABLE border=1 class='center'>");
    out.print("<TR><TD colspan='6'>LISTADO DE CLIENTES</TD></TR>");
    out.print("<TR><TH><B>Dni</B></TH><TH><B>Nombre</B></TH><TH><B>Apellido</B></TH><TH><B>Teléfono</B></TH><TH><B>Ficha</B></TH><TH><B>Eliminar</B></TH></TR>");

    for (Client elem : clientList.getClientList((String) session.getAttribute("user"))) {
        out.print("<TR>");
        out.print("<TD>" + elem.getId() + " " + calculateDniLetter.getDniLetter(elem.getId(), (String) session.getAttribute("user")) + "</TD>");
        out.print("<TD>" + elem.getName() + "</TD>");
        out.print("<TD>" + elem.getSurame() + "</TD>");
        out.print("<TD>" + elem.getTelephone() + "</TD>");
        out.print("<FORM action='FrontController' method='post'>");
        out.print("<INPUT type='hidden' name='command' value='Policies'>");
        out.print("<INPUT type='hidden' name='listPolicy' value='1'>");
        out.print("<INPUT type='hidden' name='dni' value='" + elem.getId() + "'>");
        out.print("<INPUT type='hidden' name='nombre' value='" + elem.getName() + "'>");
        out.print("<INPUT type='hidden' name='apellido' value='" + elem.getSurame() + "'>");
        out.print("<INPUT type='hidden' name='telefono' value='" + elem.getTelephone() + "'>");
        out.print("<TD><INPUT type='submit' value='Acceder' class='botonTable'></TD></FORM>");
        out.print("<FORM action='FrontController' method='post'>");
        out.print("<INPUT type='hidden' name='command' value='Main'>");
        out.print("<INPUT type='hidden' name='deleteClient' value='" + elem.getId() + "'>");
        out.print("<TD><INPUT type='submit' value='Eliminar' class='botonTable'></TD>"
                + "</FORM>");
        out.print("</TR>");
    }
    out.print("</TABLE>");
%>
<jsp:include page="footer.jsp"/>
