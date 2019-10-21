<%-- 
    Document   : welcome
    Created on : Sep 30, 2019, 9:49:33 AM
    Author     : SA
--%>

<%@page import="java.io.File"%>
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
        <title>FriutEats-Insert Product</title>
        
        <link href="../style/bootstrap.css" type="text/css" rel="stylesheet"/>
        <link rel="stylesheet" href="../style/astyle.css" type="text/css" rel="stylesheet">
    </head>
    <body>
        <%
            if (session.getAttribute("aname_s")==null) {
                    response.sendRedirect("admin_login.jsp");
                }
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
                                <a href="view_afaq.jsp" class="btn btn-success">View F.A.Q</a> 
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
                            <img width="200px" src="../img/header.png" /><br>
                            <h5 class="badge badge-danger">Hi!, Wanna Edit Data!!! </h5>
                            
                                        <% String value1 = request.getParameter("edit_faq_id");
                                            try{
                                            connection = DriverManager.getConnection(connectionUrl+database, userid, password);
                                            statement=connection.createStatement();
                                            String sql ="select * from faq where id = "+Integer.parseInt(value1);
                                            resultSet = statement.executeQuery(sql);
                                            while(resultSet.next()){
                                            %>

                                        <h4 class="badge badge-dark">Try Now!</h4>
                                        <h5 class="badge badge-success">Admin: ${aname_s}</h5>
                                        
                                         <form action="../EditEFAQ" method="post">
                                             <input type="hidden" name="edit_efaq_id" value="<%=Integer.parseInt(value1)%>">
                                            <div class="form-group">
                                                <label for="titleInputEmail1" class="badge badge-light">Product Type</label>
                                                <input type="text" class="form-control" name="equestion" placeholder="Enter Question." value="<%=resultSet.getString("question") %>"><br>
                                                <textarea class="form-control" name="eanswer" placeholder="Enter fruit description."  ><%=resultSet.getString("answer") %></textarea>
                                            </div>
                                            <button type="submit" class="btn btn-success">Update F.A.Q</button>
                                          </form>   

                                       <%
                                            }
                                            connection.close();
                                            } catch (Exception e) {
                                            e.printStackTrace();
                                            }

                                        %>             

			</div>
		</div>
            
            
            
    </body>
</html>
