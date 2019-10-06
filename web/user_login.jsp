<%-- 
    Document   : user_login
    Created on : Sep 30, 2019, 12:36:58 PM
    Author     : SA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="style/bootstrap.css" type="text/css" rel="stylesheet"/>
    </head>
    <body>
    <center><h1>Login</h1></center>
        <form action="" method="post">
            <table align="center">
                <tr>
                    <th align="right">UserName: </th>
                    <td><input type="text" name="uname"></td>
                </tr>
                <tr>
                    <th align="right">Password: </th>
                    <td><input type="text" name="upass"></td>
                </tr>
                <tr>
                    <td colspan="2" align="right"><input type="submit" value="Login" class=""</td>
                </tr>
            </table>
        </form>
    </body>
</html>
