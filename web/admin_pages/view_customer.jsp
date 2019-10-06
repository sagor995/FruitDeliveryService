<%-- 
    Document   : view_product
    Created on : Oct 5, 2019, 3:15:46 PM
    Author     : SA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Customer Data.</title>
        <link href="../style/bootstrap.css" type="text/css" rel="stylesheet"/>
        <link href="../style/astyle.css" type="text/css" rel="stylesheet">
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
                            <img width="200px" src="../img/header.png" /><br>
                            <h5 class="badge badge-danger">Hi!, Here is your customer data!!!</h5>
                                        <h4 class="badge badge-dark">Check Now!</h4>
                                        <h5 class="badge badge-success">Admin: ${aname_s}</h5>
<!--                                         <div class="table-container">-->
                                        <table class="table table-hover table-active">
                                            <thead>
                                              <tr>
                                                <th scope="col" id="col_id">#</th>
                                                <th scope="col" id="col_id">Customer Ip</th>
                                                <th scope="col" id="col_id">Customer Name</th>
                                                <th scope="col" id="col_id">Customer Image</th>
                                                <th scope="col" id="col_id">Customer Email</th>
                                                
                                                <th scope="col" id="col_id">Customer Contact</th>
                                                <th scope="col" id="col_id">Customer Address</th>
                                                <th scope="col" id="col_id">Customer Gender</th>
                                                <th scope="col" id="col_id">Customer City</th>
                                                <th scope="col" id="col_id">Customer Country</th>
                                                <th scope="col" id="col_id">Delete</th>
                                              </tr>
                                            </thead>
                                            <tbody>
                                                <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/fruit_ds" user="root" password="" />
                                                <sql:query var="rs" dataSource="${db}">select * from customer;</sql:query>
                                                <c:forEach items="${rs.rows}" var="row">
                                                    <tr>
                                                       <th scope="row" id="col_id">${row.customer_id}</th>
                                                       <th id="col_id">${row.customer_Ip}</th>
                                                        <th id="col_id">${row.customer_name}</th>
                                                        <th id="col_id"><img src='../customer_img/${row.customer_image}' width='120' height='120' /></th>
                                                        <th id="col_id">${row.customer_email}</th>
                                             
                                                        <th id="col_id">${row.customer_contact}</th>
                                                        <th id="col_id">${row.customer_address}</th>
                                                        <th id="col_id">${row.customer_gender}</th>
                                                        <th id="col_id">${row.customer_city}</th>
                                                        <th id="col_id">${row.customer_country}</th>
                                                        <th id="col_id">
                                                            <form method="get" action="../DeleteCustomerData">
                                                            <input type="hidden" name="c_id" value="${row.customer_id}">
                                                            <input type="submit" class="btn btn-close" value="X">
                                                            </form>
                                                        </th>
                                                    </tr> 
                                                </c:forEach>
                                            </tbody>
                                          </table>
<!--                                         </div>-->
			</div>
		</div> 

        

          
    </body>
</html>
