<%-- 
    Document   : register
    Created on : 06-jun-2018, 17:33:24
    Author     : Jorge
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style.css">
        <title>Torniquete seguros s.a.</title>
    </head>
    <jsp:include page="headerB.jsp"/>
    <body>
        <FORM action='FrontController' method='post'>
            <TABLE border=1 class='center'>
                <TR><TH>REGISTRO</TH></TR>
                <TR><TD><INPUT type='text' name='user' value='' minlength='5' placeholder='Usuario' required='true'></TD></TR>
                <TR><TD><INPUT type='pass' name='pass' value='' minlength='5' placeholder='Contraseña' required='true'></TD></TR>
                <TR><TD><INPUT type='text' name='email' value='' minlength='5' placeholder='Email' required='true'></TD></TR>
                <TR><TD><INPUT type='submit' value='Registrarme' class='botonTable'></TD></TR>
                <INPUT type='hidden' name='command' value='Register'>
            </TABLE>
        </FORM>
    </body>
    <jsp:include page="footer.jsp"/>
</html>
