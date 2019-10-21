/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.login;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author SA
 */
@WebServlet("/EditEFAQ")
public class EditEFAQ extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        try {
            String pro_id = req.getParameter("edit_efaq_id");
        String qstn = req.getParameter("equestion");
        String ans = req.getParameter("eanswer"); 

        
         Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fruit_ds","root","");
        PreparedStatement ps = con.prepareStatement("update faq set question=?,answer=? where id=?");

        ps.setString(1, qstn);
        ps.setString(2, ans);
        ps.setString(3, pro_id);
        
        if (ps.executeUpdate() >0) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('F.A.Q updated successfully.');");
           out.println("location='admin_pages/view_afaq.jsp';");
            out.println("</script>");
            //resp.sendRedirect("");
            //out.print(ps.getResultSet().toString());     
        }else{
            out.println("<script type=\"text/javascript\">");
            out.println("alert('F.A.Q can't be updated. Try again later.');");
           out.println("location='admin_pages/view_afaq.jsp';");
            out.println("</script>");
            //out.print(ps.getResultSet().toString());   
        }
        
        
    }catch(Exception e){
        out.println(e.getMessage());
    }
        
    }

   
}
