<%-- 
    Document   : user_register
    Created on : Oct 13, 2019, 11:36:20 PM
    Author     : SA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FruitEats-Signup</title>
        <link rel="stylesheet" href="style/user_register.css">
        <link href="style/font_awesome/css/font-awesome.min.css" rel="stylesheet">
    </head>
    <body>

        <div id="main">
         
        <div class="main-img" >
            
            <img class="mySlides" src="img/bg3.jpg" style="width: 100%"> 
            
        </div>
            <a id="close" href="index.jsp"><i class="fa fa-times" aria-hidden="true"></i></a>
        
        <a href="index.jsp"><center><img src="img/header3.png" height="100px" class="rounded mx-auto d-block" id="header_logo"/></center></a>
        <div id="sign">
            
            <form id="form" method="post" action="registerAction" enctype="multipart/form-data" style="min-height: 1150px;">
                <h1>Sign Up</h1>
                <p>Please fill in this form to create an account.</p>
                <hr>
                <label for="name"><b>Name</b></label>
                <input type="text" placeholder="Full Name" name="name" required>
                <br>
                <label for="uphoto" class="badge badge-light"><b>Select a Profile Picture</b></label><br><br>
                <input type="file" name="uphoto" placeholder="UserIamge"  class="form-control-file" id="exampleFormControlFile1" required>
                <br>
                <br>
                <label for="email"><b>Email</b></label>
                <input type="text" placeholder="Email" name="email" required>

                <label for="password"><b>Password</b></label>
                <input type="password" placeholder="Enter Password" name="password" required>

                <label for="password_repeat"><b>Repeat Password</b></label>
                <input type="password" placeholder="Repeat Password" name="password_repeat" required>
                
                <label for="country"><b>Country</b></label>
                <select class="drop" name="country" required>
                    <option selected disabled>-- Select one --</option>
                    <option value="Bangladesh">Bangladesh</option>
                    <option value="India">India</option>
                    <option value="Sri Lanka">Sri Lanka</option>
                    <option value="China">China</option>
                    <option value="Nepal">Nepal</option>
                </select>
                
                <label for="city"><b>City</b></label>
                <select class="drop" name="city" required>
                    <option selected disabled>-- Select one --</option>
                    <option value="Dhaka">Dhaka</option>
                    <option value="Delhi">Delhi</option>
                    <option value="Colombo">Colombo</option>
                    <option value="Beijing">Beijing</option>
                    <option value="Kathmandu">Kathmandu</option>
                </select>

                <label for="contact"><b>Phone</b></label>
                <input type="text" placeholder="Phone no." name="contact" required>

                <label for="address"><b>Address</b></label>
                <br>
                <textarea class="textbox" rows="5" cols="30" name="address" required></textarea>
                
                <label for="gender"><b>Gender</b></label>
                <input type="radio" name="gender" value="male" required>Male
                <input type="radio" name="gender" value="female" required> Female<br><br>

                <input id="log-in" type="submit" name="register" value="Register">
                <input id="reset" type="reset" value="Reset">
                
                <%
                    String isPasswordMatched = (String)session.getAttribute("isPasswordMatched");
                    if(isPasswordMatched != null){
                        out.println("<div class=\"alert alert-warning alert-dismissible\">");
                        out.println("    <strong>Error!</strong> The passwords did not match.");
                        out.println("</div>");
                        session.setAttribute("isPasswordMatched", null);
                    }
                %>
            </form>
            </div>

        </div>
        
        
    </body>
</html>
