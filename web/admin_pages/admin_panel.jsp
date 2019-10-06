<%-- 
    Document   : welcome
    Created on : Sep 30, 2019, 9:49:33 AM
    Author     : SA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
String id = request.getParameter("userid");
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "fruit_ds";
String userid = "root";
String password = "";
try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FriutEats</title>
        
        <link href="../style/bootstrap.css" type="text/css" rel="stylesheet"/>
        <link rel="stylesheet" href="../style/astyle.css" type="text/css" rel="stylesheet">
    </head>
    <body>
        
        <%
            if (session.getAttribute("aname_s")==null) {
                    response.sendRedirect("admin_login.jsp");
                }
        %>
        
        <%
        try{
        connection = DriverManager.getConnection(connectionUrl+database, userid, password);
        statement=connection.createStatement();
        String sql ="SELECT (SELECT COUNT(*) FROM products) as total_pro, (SELECT COUNT(*) FROM invoice_info) as total_order, (SELECT COUNT(*) FROM customer) as total_cus, (SELECT COUNT(*) FROM messages) as total_msg;";
        resultSet = statement.executeQuery(sql);
        while(resultSet.next()){
        %>
        
        <div class="main_wrapper" >
           
<!--            <a href="admin_panel.jsp" ><div id="head_img"></div></a>-->
			<div id="right">
                        <center>
                            <a href="admin_panel.jsp" class="btn btn-light"><h5 style="text-align: center;" class="btn btn-outline-danger">
                                        Manage Content</h5></a>
                                <a href="../index.jsp" target="_blank" class="btn btn-light">View Site</a>
                                <a href="insert_product.jsp" class="btn btn-success">Insert New Fruit</a>
                                <a href="view_product.jsp" class="btn btn-success">Fruits List</a>
                                <a href="insert_type.jsp" class="btn btn-success">Insert Fruit Type</a>
                                <a href="view_type.jsp" class="btn btn-success">View All Types</a>
                                <a href="view_customer.jsp" class="btn btn-success">Customers</a>
                                <a href="view_order.jsp" class="btn btn-success">Orders</a>
                                <a href="edit_images.jsp" class="btn btn-success">Update Images</a>
                                <a href="edit_slide_images.jsp" class="btn btn-success">Update Slides</a>
                                <a href="update_newsfeed_message.jsp" class="btn btn-success">News Feed</a>
                                <a href="view_customer_message.jsp" class="btn btn-success">Customer Message</a>
                                <a href="view_reports.jsp" class="btn btn-success">View Reports</a> 
                                <form method="get" action="../Logout_Admin">
                                    <input type="submit" class="btn btn-danger" value="Admin Logout" style="text-align: center;
                                        margin: 5px 5px 5px 5px;
                                        text-decoration: none;
                                        font-size: 18px;
                                        font-family: palatino;
                                        border: 2px solid black;padding: 6px;
                                         display: block;">
                                </form>
                        </center>
			</div>
                        
			<div id="left">
                            <img width="200px" src="../img/header4.png" /><br>
                            <h5 class="badge badge-danger">Hi!, You Have Successfully Logged in!!!</h5>
                                        <h4 class="badge badge-dark">Welcome to FruitEats Admin Panel</h4>
                                        <h5 class="badge badge-success">Admin: ${aname_s}</h5>
                                        
                                        <table class="table" style="width: 900px;">
<!--                                            <thead>
                                              <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">First</th>
                                                <th scope="col">Last</th>
                                                <th scope="col">Handle</th>
                                              </tr>
                                            </thead>-->
                                            <tthead>
                                              <tr>
                                                <th >
                                                    <div class="card bg-light mb-3" style="max-width: 18em;margin-top: 10px;">
                                                    <div class="card-header bg-transparent border-success">Total Post:</div>
                                                    <div class="card-body text-success">
                                                        <center><h5 class="card-title text-success">--------</h5>
                                                      <img class="card-img-top" src="../admin_img/post.png" style="width: 100px;" alt="Card image cap">
                                                      <p class="card-text text-success"><%=resultSet.getString("total_pro") %></p></center>
                                                    </div>
                                                    <div class="btn btn-success">More info.</div>
                                                  </div>
                                                </th>
                                                <th >
                                                    <div class="card bg-light mb-3" style="max-width: 18em;margin-top: 10px;">
                                                    <div class="card-header bg-transparent border-success">Total Customer:</div>
                                                    <div class="card-body text-success">
                                                        <center><h5 class="card-title text-success">--------</h5>
                                                            <img class="card-img-top" src="../admin_img/customer.png" style="width: 130px;" alt="Card image cap">
                                                      <p class="card-text text-success"><%=resultSet.getString("total_cus") %></p></center>
                                                    </div>
                                                    <div class="btn btn-success">More info.</div>
                                                  </div>
                                                </td>
                                                <th >
                                                     <div class="card bg-light mb-3" style="max-width: 18em;margin-top: 10px;">
                                                        <div class="card-header bg-transparent border-success">Total Message:</div>
                                                        <div class="card-body text-success">
                                                            <center><h5 class="card-title text-success">--------</h5>
                                                                <img class="card-img-top" src="../admin_img/message.png" style="width: 100px;" alt="Card image cap">
                                                          <p class="card-text text-success"><%=resultSet.getString("total_msg") %></p></center>
                                                        </div>
                                                        <div class="btn btn-success">More info.</div>
                                                      </div>
                                                </th>
                                                <th >
                                                        <div class="card bg-light mb-3" style="max-width: 18em;margin-top: 10px;">
                                                        <div class="card-header bg-transparent border-success">Total Orders:</div>
                                                        <div class="card-body text-success">
                                                            <center><h5 class="card-title text-success">--------</h5>
                                                                <img class="card-img-top" src="../admin_img/order.png" style="width: 100px;" alt="Card image cap">
                                                          <p class="card-text text-success"><%=resultSet.getString("total_order") %></p></center>
                                                        </div>
                                                        <div class="btn btn-success">More info.</div>
                                                      </div>
                                                </th>
                                              </tr>
<!--                                              <tr>
                                                  
                                                <td>
                                                
                                                </td>
                                                <td>
                                                
                                                </td>
                                              </tr>-->
                                            </thead>
                                          </table>
                                                   
			</div>
		</div> 
                                        
         <%
        }
        connection.close();
        } catch (Exception e) {
        e.printStackTrace();
        }
        %> 
    </body>
</html>
