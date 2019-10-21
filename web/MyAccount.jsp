<%-- 
    Document   : index
    Created on : Sep 30, 2019, 6:59:44 PM
    Author     : SA
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.net.InetAddress"%>
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
        <link rel="stylesheet" href="style/ustyle.css" type="text/css" rel="stylesheet">
        <link href="style/bootstrap.css" type="text/css" rel="stylesheet"/>
        <link href="style/font_awesome/css/font-awesome.css" type="text/css" rel="stylesheet"/>
        <title>FruitEats</title>
    </head>
    <body bgcolor="lightgreen">
<!--        For reading single data-->
        <%
        try{
        connection = DriverManager.getConnection(connectionUrl+database, userid, password);
        statement=connection.createStatement();
        String sql ="select * from others where id = 2;";
        resultSet = statement.executeQuery(sql);
        while(resultSet.next()){
        %>
        
        <div class="main_wrapper">
            
            <div class="header_wrapper">
                <a href="index.jsp"><img src="img/<%=resultSet.getString("header_image") %>" class="rounded mx-auto d-block" id="header_logo"/></a>
                    <img id="header_banner" class="img-fluid" src="img/<%=resultSet.getString("ads_cover_image") %>">
            </div>
            
            <!--shopping cart starts -->
            <div id="shopping_cart">
                            <span style="float: right; font-size: 18px; padding: 5px; line-height: 30px;">
                            <%
                                String loggedIn="";
                                if (session!=null) {
                                        loggedIn = (String)session.getAttribute("username");
                                        if(loggedIn != null){
                                            out.println("<b>Welcome:<b/>"+loggedIn+" | <b style='color: black'>Your </b>");
                                        }else{
                                            out.println("<b>Welcome Guest!</b>");
                                            response.sendRedirect("user_login.jsp");
                                        }
                                    }
                                
                           %>
                            <i class="fa fa-shopping-cart"></i> Cart item: <span class="badge"> 
                                <%
                                InetAddress localhost = InetAddress.getLocalHost();
                                String ipp = (localhost.getHostAddress()).trim();
                                PreparedStatement ps = (PreparedStatement) connection.prepareStatement("SELECT COUNT(*) as total_products_in_cart FROM cart where ip_address=?");
                                ps.setString(1, ipp);
                                ResultSet rs = ps.executeQuery();
                                int quantity=0;
                                if (rs.next()) {
                                    %>
                                <%=rs.getString("total_products_in_cart") %>
                               <%
                                }
                                %>
                            </span> | <a href="cart.jsp" style="color: black;"> Go To Cart</a>
                    </span>
            </div>
            
            <div class="menubar" >
                                <nav class="navbar navbar-expand-sm navbar-light bg-warning">
                                    <a class="navbar-brand" href="index.jsp">Home</a>
                                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                                      <span class="navbar-toggler-icon"></span>
                                    </button>

                                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                      <ul class="navbar-nav mr-auto">
                                        <li class="nav-item active">
                                            <a class="nav-link" href="All.jsp">All<span class="sr-only">(current)</span></a>
                                        </li>
                                        
                                         <li class="nav-item">
                                          <a class="nav-link" href="AboutUs.jsp">About</a>
                                        </li>
                                        
                                        <li class="nav-item">
                                          <a class="nav-link disabled" href="FaqInfo.jsp" tabindex="-1" aria-disabled="true">F.A.Q</a>
                                        </li>
                                        
                                        <li>
                                            <%
                                            if(loggedIn != null){
                                                %>
                                                 <a class="nav-link" href="MyAccount.jsp">My Account</a>
<!--                                               <form method="get" action="u_logout">
                                                <input type="submit" class="btn btn-danger" value="Logout" style="text-align: center;
                                                        margin: 1px 2px 1px 1px;
                                                        text-decoration: none;
                                                        font-size: 15px;
                                                        font-family: palatino;
                                                        border: 2px solid black;
                                                        padding: 2px;
                                                         display: block;">
                                                </form>-->
                                            <%
                                            }else{
                                                
                                                out.println("<b><a class='btn btn-warning' href='user_login.jsp' >Login</a></b>");
                                            }
                                            %>
                                        </li>
                                      </ul>
                                        
                                      <form method="get" action="search.jsp" id="form" class="form-inline my-2 my-lg-0">
                                        <input class="form-control mr-sm-2" name="sresult"  type="search" placeholder="Search" aria-label="Search">
                                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
<!--                                    <input type="text" class="btn btn-outline-success my-2 my-sm-0" name="user_query" placeholder="Search..."/>-->
                                      </form>
                                    </div>
                                  </nav>    
            </div>

         
            
            
            
            <%
        }
       
        } catch (Exception e) {
        e.printStackTrace();
        }
        %>                    
                                
                                
            <div id="content_area">
                            <div id="products_box">
                                <div id="right" class="card">
                                <center>
                                    <h5 style="text-align: center;margin-top: 5px;" class="btn btn-success">
                                               My Account</h5>
                                       
<!--                                        <a style="text-align: center;margin-top: 10px;" href="MyAccount.jsp" class="btn btn-outline-warning">View Profile</a>-->
                                        <a style="text-align: center;margin-top: 10px;" href="MyOrder.jsp" class="btn btn-outline-warning">View Orders</a>
 
                                        <form method="get" action="u_logout">
                                            <input type="submit" class="btn btn-outline-danger" value="Logout" style="text-align: center;
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
                                        
                                        <%
                                String vString = (String)session.getAttribute("username");
                                String[] part = vString.split(":");
                                
                                PreparedStatement ps = (PreparedStatement) connection.prepareStatement("SELECT * FROM customer where customer_email=?");
                                ps.setString(1, part[1]);
                                ResultSet rs = ps.executeQuery();
                                
                                if (rs.next()) {
                                    %>
                                        <div class="card" style="width: 20rem; margin-top: 10px;margin-bottom: 10px;">
                                            <center><div class="card-body">
                                            <p id="about-text1">User Profile</p>
                                            </div></center>
                                            <img src='customer_img/<%=rs.getString("customer_image")%>' class="card-img-top" alt="profile_image">
                                            <div class="card-body">
                                              <h5 class="card-title"><%=rs.getString("customer_name")%></h5>
                                              <p class="card-text">Address, City, Country:<br></b><%=rs.getString("customer_address")%>,<%=rs.getString("customer_city")%>,<%=rs.getString("customer_country")%>.</p>
                                            </div>
                                            <ul class="list-group list-group-flush">
                                              <li class="list-group-item"><b>Gender:</b><%=rs.getString("customer_gender")%></li>
                                              <li class="list-group-item"><b>Email:</b><%=rs.getString("customer_email")%></li>
                                              <li class="list-group-item"><b>Phone:</b><%=rs.getString("customer_contact")%></li>
                                            </ul>
                                            <div class="card-body">
                                                <center>
                                                    <a href='EditUProfile.jsp?cust_id=<%=rs.getString("customer_id")%>' class="btn btn-success">Update Details</a>
                                                    
<!--                                                    <form method="post" action="EditUProfile.jsp">
                                                  <input type="hidden" name="cust_id" value=''/>
                                                  <input type="submit"  style='float:left;' class="btn btn-success" value="Update Details">
                                              </form>-->
                                                </center>
                                            </div>
                                          </div>
                                    <%
                                        }
                                    connection.close();
                                        %>
                            </div>

            </div>
                                        
            <div class="footer_wrapper">
                <center><h5 id="cpy_text" class="badge badge-pill" >&copy;2019 FruitEats. All rights reserved.<b> | </b><a href="ContactUs.jsp" id="contact_us">Contact Us</a></h5></center>
            </div>
        </div>
    </body>
</html>
