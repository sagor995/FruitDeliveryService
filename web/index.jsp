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
                                String loggedIn = (String)session.getAttribute("username");
                                if(loggedIn != null){
                                    out.println("<b>Welcome:<b/>"+loggedIn+" | <b style='color: black'>Your </b>");
                                }else{
                                    out.println("<b>Welcome Guest!</b>");
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

            <div class="type_wrapper">
                    <!--Sidebar starts -->
                    <div id="Typebar">
                                        <center> <label class="badge badge-dark">Types</label></center>
                                    <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/fruit_ds" user="root" password="" />
                                    <sql:query var="rs1" dataSource="${db}">select * from types;</sql:query>
                                    
                                        <ul class="list-group">
                                            <c:forEach items="${rs1.rows}" var="row1">
                                                <a href="index_type.jsp?type_sresult=${row1.type_title}" class="list-group-item list-group-item-action">
                                                    ${row1.type_title}
                                                    <span class="badge badge-success badge-pill"></span>
                                                 </a>
                                             </c:forEach>
                                        </ul>
                                   
                    </div>
                    <!--Sidebar ends -->
                    <div id="slide_area">
                        
                        <img class="mySlides w3-animate-fading" src="slide_img/<%=resultSet.getString("slide_image_1") %>" height="99.9%" style="width:99.9%">
                        <img class="mySlides w3-animate-fading" src="slide_img/<%=resultSet.getString("slide_image_2") %>" height="99.9%" style="width:99.9%">
                         <img class="mySlides w3-animate-fading" src="slide_img/<%=resultSet.getString("slide_image_3") %>" height="99.9%" style="width:99.9%">
                         <img class="mySlides w3-animate-fading" src="slide_img/<%=resultSet.getString("slide_image_4") %>" height="99.9%" style="width:99.9%">
                         <img class="mySlides w3-animate-fading" src="slide_img/<%=resultSet.getString("slide_image_5") %>" height="99.9%" style="width:99.9%">
                         <img class="mySlides w3-animate-fading" src="slide_img/<%=resultSet.getString("slide_image_6") %>" height="99.9%" style="width:99.9%;">
                                    
                                    <script>
                                            var myIndex = 0;
                                            carousel();

                                            function carousel() {
                                                var i;
                                                var x = document.getElementsByClassName("mySlides");
                                                for (i = 0; i < x.length; i++) {
                                                   x[i].style.display = "none";  
                                                }
                                                myIndex++;
                                                if (myIndex > x.length) {myIndex = 1}    
                                                x[myIndex-1].style.display = "block";  
                                                setTimeout(carousel, 4000);    
                                            }
                                    </script>
                    </div>
            </div>
            
            <div id="news_feed_area" style="height: 40px;background: black;color: white;">
                            <h5 style="padding-top: 5px; "><marquee behavior='scroll' direction='left'>
        <%=resultSet.getString("news_feed") %>
                                </marquee></h5>

            </div>
            <div id="banner_area" >
                <img src="img/<%=resultSet.getString("ads_center_image") %>" width="995px" height="193px"/>
            </div>
            
            <%
        }
        connection.close();
        } catch (Exception e) {
        e.printStackTrace();
        }
        %>                    
                                
                                
            <div id="content_area">
                            <div id="products_box">


                                    
                            </div><sql:query var="rs" dataSource="${db}">select * from products limit 9;</sql:query>
                                    <c:forEach items="${rs.rows}" var="row">
                                        
                                        
                                        <div id='single_product_homepage' class="card">
                                            <center><h4 id='homePageTitle' class="card-title">${row.product_title}</h4></center>
                                            <img src='fruit/${row.product_image}' class="card-img-top" width='100' height='130' />
                                            <div class="card-body">
                                            <center><p id='price'  class="card-text"><b>Price: ${row.product_price} Tk.</b></p></center>
                                            <center><p id='des' class="card-text"><b>Info: ${row.product_description}</b></p></center>
                                            </div>
                                            <div class="card-body">
                                            <a href='view_products.jsp?view_pro_id=${row.product_id}'><button class='btn btn-light' style='float:left;'>View</button></a>
<!--                                            <a href='index.php?add_cart=${row.product_id}'><button class='btn btn-success' style='float:right;'>Add to Cart</button></a>-->
                                            
                                                <form method="post" action="productAddAction">
                                                    <input type="hidden" name="pro_id" value="${row.product_id}"/>
                                                    <input type="submit"  name="add" style='float:right;' class="btn btn-success" value="Add to Cart">
                                                </form>
                                            </div>   
                                            
                                        </div>
                                    </c:forEach>

            </div>
                                        
            <div class="footer_wrapper">
                <center><h5 id="cpy_text" class="badge badge-pill" >&copy;2019 FruitEats. All rights reserved.<b> | </b><a href="ContactUs.jsp" id="contact_us">Contact Us</a></h5></center>
            </div>
        </div>
    </body>
</html>
