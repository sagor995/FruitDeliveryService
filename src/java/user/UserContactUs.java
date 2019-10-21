/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package user;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.jasper.tagplugins.jstl.core.Catch;

/**
 *
 * @author SA
 */
@WebServlet("/ucontact_us")
public class UserContactUs extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        try{
            String name = req.getParameter("uname");
            String email = req.getParameter("uemail");
            String sub = req.getParameter("usub");
            String msg = req.getParameter("ucomments");

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/fruit_ds?zeroDateTimeBehavior=convertToNull","root","");
            PreparedStatement ps = (PreparedStatement) con.prepareStatement("INSERT INTO messages (customer_ip, customer_name, customer_email, subject, message) values (?, ?, ?, ?, ?);");
        
                InetAddress localhost = InetAddress.getLocalHost();
                String ip = (localhost.getHostAddress()).trim();
            
                ps.setString(1, ip);
                ps.setString(2, name);
                ps.setString(3, email);
                ps.setString(4, sub);
                ps.setString(5,msg);

        
        
                if (ps.executeUpdate() >0) {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Message has been successfully sent.');");
                    out.println("location='ContactUs.jsp';");
                    out.println("</script>");
                    //resp.sendRedirect("");
                    //out.print(ps.getResultSet().toString());     
                }else{
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Data insertion failed.');");
                    out.println("location='ContactUs.jsp';");
                    out.println("</script>");
                    //out.print(ps.getResultSet().toString());   
                }
                
                
        }catch(Exception e){
        e.printStackTrace();
         }
    }
    
}

