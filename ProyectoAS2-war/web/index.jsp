<%-- 
    Document   : index
    Created on : 26-feb-2018, 14:18:53
    Author     : Jorge
--%>

<%@page import="javax.naming.NamingException"%>
<%@page import="com.as.practica2.User"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="com.as.practica2.UserBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    
    if (session.getAttribute("user") != null) {
        response.sendRedirect("main.jsp");
    }
    
    if (session.getAttribute("userList") == null) {
        try {
            UserBean userBean = InitialContext.doLookup("java:global/ProyectoAS2/ProyectoAS2-ejb/UserBean");
            session.setAttribute("userList", userBean);
            UserBean userList = (UserBean) session.getAttribute("userList");

            userList.addUser("jorge", new User("jorge", "1234", "kovutech@gmail.com"));
            
        } catch (NamingException ex) {
        }
    }
    
    
     System.out.println();
%>
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <h1 class="title">Torniquete seguros s.a.</h1><br>
        <div class="box">
            <form action="FrontController" method='post' class="contenedorCentrado">
                <h1>Agente</h1>
                <input type="text" name="user" placeholder="User" class="inputText" required/><br><br>
                <input type="password" name="pass" placeholder="Password" class="inputText" required/><br><br>
                <input type="hidden" name="command" value="Main">
                <input type="submit" value="Login" class="boton"/>
            </form>
            <form action="FrontController" method='post'>
                <input type="hidden" name="command" value="ToRegister">
                <input type="submit" name="Registro" value="Registro" class='boton'>
            </form>
        </div>
    </body>
</html>
