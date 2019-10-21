/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package user;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 *
 * @author SA
 */
@WebServlet("/decreaseCartValue")
public class decreaseCartValue extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       PrintWriter out = resp.getWriter();
       Connection con = null;
        try {
            String qty2 = req.getParameter("de_quantity");
                String pid = req.getParameter("de_pro_id");
           
            Class.forName("com.mysql.jdbc.Driver");
                con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/fruit_ds?zeroDateTimeBehavior=convertToNull","root","");
                PreparedStatement ps = (PreparedStatement) con.prepareStatement("select * from cart where ip_address=? and product_id=?");
                
                InetAddress localhost = InetAddress.getLocalHost();
            String ip = (localhost.getHostAddress()).trim();
                
                ps.setString(1, ip);
                ps.setString(2, pid);

                ResultSet rs = ps.executeQuery();
                String quantity = "";
                int q = 0;
                
                if(rs.next()){
                    quantity = rs.getString("quantity");
                    q = Integer.parseInt(quantity);
                    q = q - 1;
                    quantity = Integer.toString(q);
                }
                
                if(q >= 0){
                    ps = (PreparedStatement) con.prepareStatement("update cart set quantity=? where product_id=? and ip_address=?");
                    ps.setString(1, quantity);
                    ps.setString(2, pid);
                    ps.setString(3, ip);
                
                    ps.executeUpdate();
                }
                else{
                    ps = (PreparedStatement) con.prepareStatement("delete from cart where product_id=? and ip_address=?");
                    ps.setString(1, pid);
                    ps.setString(2, ip);
                
                    ps.executeUpdate();
                }
                
              resp.sendRedirect("cart.jsp");
                
                
        } catch (Exception e) {
        }
    }
    
}
