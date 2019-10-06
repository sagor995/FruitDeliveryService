<%-- 
    Document   : videos
    Created on : Sep 30, 2019, 9:49:13 AM
    Author     : SA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FriutEats</title>
        <link href="style/bootstrap.css" type="text/css" rel="stylesheet"/>
    </head>
    <body>
        <%
            if (session.getAttribute("aname_s")==null) {
                    response.sendRedirect("admin_login.jsp");
                }
        %>
        <img src="header.png" width="200" height="50"/><br><br>
        <h3>Videos</h3>
        <h4>Hi!, ${aname_s}</h4>
        
        <h5>Try Now..</h5>
        <ul>
            <li><a href="admin_panel.jsp">Home</a></li>
            <li><a href="about.jsp">About</a></li>
        </ul>
        
        <h3>Currently not available at the moment.</h3>
        
        <form method="get" action="Logout_Admin">
            <input type="submit" class="btn btn-primary btn-block btn-large" value="Logout" style="background-color: red;color: white">
        </form>
    </body>
</html>
