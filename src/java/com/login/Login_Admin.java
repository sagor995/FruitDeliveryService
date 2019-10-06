/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
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

@WebServlet("/Login_Admin")
public class Login_Admin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        
    }
        
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
        PrintWriter out = resp.getWriter();
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fruit_ds","root","");
        PreparedStatement ps = con.prepareStatement("select * from admins where admin_email=? and admin_pass=?");
        
        String uname = req.getParameter("aname");
        String upass = req.getParameter("apass");
        
        ps.setString(1, uname);
        ps.setString(2, upass);
        
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            HttpSession session = req.getSession();
            session.setAttribute("aname_s", uname);
            resp.sendRedirect("admin_pages/admin_panel.jsp");
            out.println("login");
        }else
            resp.sendRedirect("admin_pages/admin_login.jsp");
            out.println("not login");
        } catch (Exception ex) {
            Logger.getLogger(Login_Admin.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    
    

   

}
