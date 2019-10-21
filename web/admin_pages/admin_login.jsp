<%-- 
    Document   : admin_login
    Created on : Sep 30, 2019, 9:48:59 AM
    Author     : SA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FruitEats-Admin Login</title>
        <link href="../style/bootstrap.css" type="text/css" rel="stylesheet"/>
        <link href="../style/astyle.css" type="text/css" rel="stylesheet"/>
    </head>
    <body bgcolor="lightgreen">
        <div class="main_wrapper">
            <img src="../img/header.png" width="200" height="50"/><br><br><br><br>
            <center><h1 >Admin Login</h1></center><br>
            <center><form action="../Login_Admin" method="post">
                    <table style="width: 500px;" class="table table-active " align="center">
                    <tr>
                        <th align="right">UserName: </th>
                        <td><input type="email" name="aname" required="required" class="form-control"></td><br>
                    </tr>
                    <tr>
                        <th align="right">Password: </th>
                        <td><input type="password" name="apass" required="required" class="form-control"></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="right"><input type="submit" value="Login" class="btn btn-success btn-block btn-large"  style="background-color: green;color: white"/></td>
                    </tr>
                </table>
             </form></center>
            <br>
            <div id="bottom_admin_login">
                <center><span class="badge badge-pill badge-light" style="margin-top: 20px;font-size: 20px;">@FruitEats 2019. All rights reserved.</span></center>
            </div>
        </div>
    </body>
</html>
