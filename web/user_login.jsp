<%-- 
    Document   : user_login
    Created on : Sep 30, 2019, 12:36:58 PM
    Author     : SA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FruitEats-Login</title>
<!--        <link href="style/bootstrap.css" type="text/css" rel="stylesheet"/>-->
        <link href="style/font_awesome/css/font-awesome.min.css" rel="stylesheet">
        <link rel="stylesheet" href="style/user_login.css">
    </head>
    <body>
        <div class="main-img" >
            <img class="mySlides" src="img/bg3.jpg" style="width: 100%"> 
          </div>
        <a id="close" href="index.jsp"><i class="fa fa-times" aria-hidden="true"></i></a>
        <a href="index.jsp"><center><img src="img/header3.png" height="100px" class="rounded mx-auto d-block" id="header_logo"/></center></a>
          <div id="sign">
              <form id="form" method="post" action="loginAction">
                  <h1>Log In</h1>
                  <p>Please fill in this form to Log-In.</p>
                  <hr>

                  <label for="email"><b>Email</b></label>
                  <input type="text" placeholder="Email" name="email" required>

                  <label for="psw"><b>Password</b></label>
                  <input type="password" placeholder="Enter Password" name="password" required>

                  <p>If you have no account, <a href="user_register.jsp" style="color:dodgerblue">Click here</a></p>

                  <input type="submit" id="log-in" name="login" value="Login"><br>
                  <%
                      String isLoggedIn = (String)session.getAttribute("isLoggedIn");
                      if(isLoggedIn != null){
                          out.println("<div class=\"alert alert-warning alert-dismissible\">");
                          out.println("    <strong>Error!</strong> The username and/or password did not match.");
                          out.println("</div>");
                          session.setAttribute("isLoggedIn", null);
                      }
                  %>
              </form>
          </div>
    </body>
</html>
