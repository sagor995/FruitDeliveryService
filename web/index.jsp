<%-- 
    Document   : index
    Created on : Sep 30, 2019, 6:59:44 PM
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
        <link rel="stylesheet" href="style/ustyle.css" type="text/css" rel="stylesheet">
        <link href="style/bootstrap.css" type="text/css" rel="stylesheet"/>
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
<!--                            <?php
                                    if (isset($_SESSION['customer_email'])){
                                            echo "<b>Welcome:<b/>".$_SESSION['customer_email']." | <b style='color: black'>Your </b>";
                                    }else{
                                            echo "<b>Welcome Guest!</b>";
                                    }
                            ?>-->

                             <b style="color: black"> Shopping Cart -</b> Total Items: 
<!--                             <?php total_items(); ?>-->
                             Total Price: 
<!--                             <?php total_price(); ?>-->
                             | <a href="cart.jsp" style="color: black;"> Go To Cart</a>
                    </span>
            </div>
            
            <div class="menubar" >
                            <div id="form">
                                <form method="get" action="" enctype="multipart/form-data">
                                    <input type="submit" name="search" value="Search" class="btn btn-warning"/>
                                    <input type="text"  name="user_query" placeholder="Search..."/>
                                    </form>
                            </div>  
                            <ul id="menu" >
                                    <li><a href="">All</a></li>
                                    <li><a href="">MyAccount</a></li>
                                    <li><a href="">Shopping Cart</a></li>
                                    <li><a href="">FAQ</a></li>
                                    <li>
<!--                                            <?php
                                            if (!isset($_SESSION['customer_email'])) {

                                                    echo "<b><a href='checkout.php' style='text-decoration: none;color: orange'>Login</a></b>";

                                            }else{
                                                    echo "<b><a href='logout.php' style='text-decoration: none;color:orange'>Logout</a></b>";

                                            }
                                            ?>-->
                                    </li>
                            </ul>
                             
                              
            </div>

            <div class="type_wrapper">
                    <!--Sidebar starts -->
                    <div id="Typebar">
                                    <ul id="brnds">
                                            <div class="tab">
                                              <button class="tablinks" onclick="openCity(event, 'type_tab')">Type</button>
                                              <button class="tablinks" onclick="openCity(event, 'recent_tab')">Recent</button>
                                            </div>

                                            <div id="type_tab" class="tabcontent">
<!--                                             <?php getBrands(); ?>-->
                                            </div>
                                            <div id="recent_tab" class="tabcontent">
<!--                                             <?php getBrands(); ?>-->
                                            </div>
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
<!--                                    <?php getProducts(); ?>
                                    <?php getBrandProducts(); ?>	
                                    <?php getCategoryProducts(); ?>-->

                                     <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/fruit_ds" user="root" password="" />
        
                                    <sql:query var="rs" dataSource="${db}">select * from products limit 12;</sql:query>
                                    <c:forEach items="${rs.rows}" var="row">
                                        
                                        
                                        <div id='single_product_homepage'>
                                            <center><h4 id='homePageTitle' class="badge badge-success">${row.product_title}</h4></center>
                                            <img src='fruit/${row.product_image}' width='200' height='180' />
                                            <center><p id='price' class="badge badge-warning"><b>Price: ${row.product_price} Tk.</b></p></center>
                                            <center><p id='des' class="badge badge-dark"><b>Info: ${row.product_description}</b></p></center>

                                            <a href='view.php?product_id=${row.product_id}'><button class='btn btn-light' style='float:left;'>View</button></a>
                                            <a href='index.php?add_cart=${row.product_id}'><button class='btn btn-success' style='float:right;'>Add to Cart</button></a>
                                        </div>
                                    </c:forEach>
                            </div>

            </div>
            <div class="footer_wrapper">
                <center><h5 id="cpy_text">&copy;2019 FruitEats. All rights reserved.<b> | </b><a href="" id="contact_us">Contact Us</a></h5></center>
            </div>
        </div>
    </body>
</html>
