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
@WebServlet("/productAddAction")
public class UserViewProduct extends HttpServlet{
    
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
        PrintWriter out = res.getWriter();
        Connection con = null;
        try {
            
            String p_id = req.getParameter("pro_id");
            Class.forName("com.mysql.jdbc.Driver");
            con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/fruit_ds?zeroDateTimeBehavior=convertToNull","root","");
            PreparedStatement ps = (PreparedStatement) con.prepareStatement("select * from cart where product_id=?");
            
            ps.setString(1, p_id);
            
            ResultSet rs = ps.executeQuery();
        
            if (rs.next()) {
                int quantity = Integer.parseInt(rs.getString("quantity"));
                quantity = quantity + 1;
                
                ps = (PreparedStatement) con.prepareStatement("update cart set quantity=? where product_id=?");
                
                ps.setString(1, Integer.toString(quantity));
                ps.setString(2, p_id);
                
                ps.executeUpdate();
                res.sendRedirect("index.jsp");
            }else{
                ps = (PreparedStatement) con.prepareStatement("INSERT INTO cart (product_id, ip_address, quantity) values (?, ?, ?);");
                
                ps.setString(1, p_id);
                ps.setString(2, ((InetAddress.getLocalHost()).getHostAddress()).trim());
                ps.setString(3, Integer.toString(1));
                
                ps.executeUpdate();
                res.sendRedirect("index.jsp");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}

