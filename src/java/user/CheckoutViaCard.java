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
import java.sql.Timestamp;
import java.util.ArrayList;
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
@WebServlet("/mastercardAction")
public class CheckoutViaCard extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        HttpSession session = req.getSession();
        
        
        
        Connection con = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/fruit_ds?zeroDateTimeBehavior=convertToNull","root","");
            PreparedStatement ps = (PreparedStatement) con.prepareStatement("select customer_id, customer_contact from customer where customer_ip=?");
            
            InetAddress localhost = InetAddress.getLocalHost();
            String ips = (localhost.getHostAddress()).trim();
            
            String total_price = req.getParameter("net_total");
            String card_number = req.getParameter("card_number");
            String cardholder_name = req.getParameter("cardholder_name");
            String billing_address = req.getParameter("billing_address");
            String month = req.getParameter("month");
            String year = req.getParameter("year");
            String cvc = req.getParameter("cvc");
            
            ps.setString(1, ips);
            ResultSet rs = ps.executeQuery();
            
            String customer_id = "";
            String customer_contact = "";
            if (rs.next()) {
                customer_id = rs.getString("customer_id");
                customer_contact = rs.getString("customer_contact");
            }
            
            ps = (PreparedStatement) con.prepareStatement("select * from cart where ip_address=?");
            
            ps.setString(1, ips);
            rs = ps.executeQuery();
            
            ArrayList<String> product_ids = new ArrayList<String>();
            ArrayList<String> product_quantities = new ArrayList<String>();
            while (rs.next()) {
                product_ids.add(rs.getString("product_id"));
                product_quantities.add(rs.getString("quantity"));
            }
            

            
            java.util.Date date=new java.util.Date();
			
            java.sql.Date sqlDate=new java.sql.Date(date.getTime());

            ps = (PreparedStatement) con.prepareStatement("INSERT INTO invoice_info (customer_id, customer_ip, card_num, card_name, card_address, card_mm, card_yy, card_cvc, product_quantity, total_price, date, status, paid_via, phone, product_names, product_qtys) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
            ps.setString(1, customer_id);
            ps.setString(2, ips);
            ps.setString(3, card_number);
            ps.setString(4, cardholder_name);
            ps.setString(5, billing_address);
            ps.setString(6, month);
            ps.setString(7, year);
            ps.setString(8, cvc);
            ps.setString(9, "1");
            ps.setString(10, total_price);
            ps.setString(11, "2019/10/15");
            ps.setString(12, "pending");
            ps.setString(13, "Card");
            ps.setString(14, customer_contact);
            
            String product_ids_string = "";
            String product_quantities_string = "";
            
            for(int i = 0; i < product_ids.size(); i++){
                product_ids_string = product_ids_string + product_ids.get(i);
                product_quantities_string = product_quantities_string + product_quantities.get(i);
                if(i != (product_ids.size() - 1)){
                    product_ids_string = product_ids_string + ",";
                    product_quantities_string = product_quantities_string + ",";
                }
            }
            
            ps.setString(15, product_ids_string);
            ps.setString(16, product_quantities_string);
            
            ps.executeUpdate();
            
            ps.close();
            
            ps = (PreparedStatement) con.prepareStatement("Delete from cart where ip_address =  ?;");
            ps.setString(1, ips);
           
            if (ps.executeUpdate()>0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Thank you for purchasing from us!');");
                out.println("location='index.jsp';");
                out.println("</script>");
            }else{
              out.println("Error occured");
            }
        } catch (Exception e) {
        }
    }
    
}
