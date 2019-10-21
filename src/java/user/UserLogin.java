/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package user;

import com.login.Login_Admin;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author SA
 */
@WebServlet("/loginAction")
public class UserLogin extends HttpServlet{
    
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
        PrintWriter out = resp.getWriter();
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fruit_ds","root","");
        PreparedStatement ps = con.prepareStatement("select * from customer where customer_email=? and customer_pass=?");
        
        String uname = req.getParameter("email");
        String upass = req.getParameter("password");
        
        ps.setString(1, uname);
        ps.setString(2, upass);
        
        ResultSet rs = ps.executeQuery();
        HttpSession session = req.getSession();
        if (rs.next()) {
            String username = rs.getString("customer_name");
            session.setAttribute("username", username+":"+uname);
            resp.sendRedirect("index.jsp");
        }else
            session.setAttribute("isLoggedIn", "false");
            resp.sendRedirect("user_login.jsp");
        } catch (Exception ex) {
            Logger.getLogger(Login_Admin.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    
}
