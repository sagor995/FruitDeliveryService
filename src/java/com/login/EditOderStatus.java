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
@WebServlet("/EditOderStatus")
public class EditOderStatus extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        try {
        String status = req.getParameter("status_change");
        String s_id = req.getParameter("edit_ord_id"); 

        //out.println(status+""+s_id);
        
         Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fruit_ds","root","");
        PreparedStatement ps = con.prepareStatement("update invoice_info set status=? where id=?");

        ps.setString(1, status);
        ps.setString(2, s_id);
        
        if (ps.executeUpdate() >0) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Order status updated successfully.');");
            out.println("location='admin_pages/view_order.jsp';");
            out.println("</script>");
            //resp.sendRedirect("");
            //out.print(ps.getResultSet().toString());     
        }else{
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Order status can't be updated. Try again later.');");
            out.println("location='admin_pages/edit_order_status.jsp';");
            out.println("</script>");
            //out.print(ps.getResultSet().toString());   
        }
        
        
    }catch(Exception e){
        out.println(e.getMessage());
    }
        
    }

   
}
