/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package user;

import com.login.*;
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
@WebServlet("/DeleteOrderUData")
public class DeleteOrderUData extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       PrintWriter out = resp.getWriter();
        try {
            String oid = req.getParameter("delete_order_id");
            
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fruit_ds","root","");
        PreparedStatement ps = con.prepareStatement("delete from invoice_info where id = ?");
        ps.setInt(1, Integer.parseInt(oid));
        
        if (ps.executeUpdate() >0) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('data successfully deleted.');");
            out.println("location='MyOrder.jsp';");
            out.println("</script>");
            //resp.sendRedirect("");
            //out.print(ps.getResultSet().toString());     
        }else{
            out.println("<script type=\"text/javascript\">");
            out.println("alert('data can't be deleted.');");
            out.println("location='MyOrder.jsp';");
            out.println("</script>");
            //out.print(ps.getResultSet().toString());   
        }
            
            
            }catch(Exception e){
        out.println(e.getMessage());
        }
    }
    
  
   
}
