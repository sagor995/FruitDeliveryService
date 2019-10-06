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
@WebServlet("/InsertType")
public class InsertType extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        try {

        String ftype = req.getParameter("fruit_type");
        
         Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fruit_ds","root","");
        PreparedStatement ps = con.prepareStatement("insert into types(type_title) values(?)");
        ps.setString(1, ftype);
        if (ps.executeUpdate() >0) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Data inserted successfully.');");
            out.println("location='admin_pages/view_type.jsp';");
            out.println("</script>");
            //resp.sendRedirect("");
            //out.print(ps.getResultSet().toString());     
        }else{
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Data insertion failed.');");
            out.println("location='admin_pages/insert_type.jsp';");
            out.println("</script>");
            //out.print(ps.getResultSet().toString());   
        }
        
        
    }catch(Exception e){
        out.println(e.getMessage());
    }
        
    }
    
    private String extractFileName(Part part) {
    String contentDisp = part.getHeader("content-disposition");
    String[] items = contentDisp.split(";");
    for (String s : items) {
        if (s.trim().startsWith("filename")) {
            return s.substring(s.indexOf("=") + 2, s.length()-1);
        }
    }
    return "";
}
   
}
