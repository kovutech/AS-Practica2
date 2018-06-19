<%-- 
    Document   : stadistics
    Created on : 18-jun-2018, 13:29:15
    Author     : Jorge
--%>

<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="com.as.practica2.singleton.LogBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <%
            LogBean logBean = InitialContext.doLookup("java:global/ProyectoAS2/ProyectoAS2-ejb/LogBean");
            List<String> aux = logBean.getTraza();

            for (String elem : aux) {
                out.println(elem);
                out.println("\n");
            }


        %>
    </body>
</html>
