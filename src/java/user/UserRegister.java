/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package user;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author SA
 */
@WebServlet("/registerAction")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
             maxFileSize=1024*1024*10,      // 10MB
             maxRequestSize=1024*1024*50)
public class UserRegister extends HttpServlet{
    
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
        PrintWriter out = res.getWriter();
        try{
            
            String relativeWebPath = "/customer_img";
            String slash = "build";
           String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);
           absoluteDiskPath = absoluteDiskPath.replaceAll(slash, "");
           absoluteDiskPath = absoluteDiskPath.replace("\\\\", File.separator.toString());
           
           String savePath = absoluteDiskPath ; //specify your path here
        
            File fileSaveDir=new File(savePath);
            if(!fileSaveDir.exists()){
                fileSaveDir.mkdir();
            }
            out.println(""+savePath); 
            Part part=req.getPart("uphoto");
            String fileName=extractFileName(part);
            part.write(savePath + "\\" + fileName);
            
            
            
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/fruit_ds?zeroDateTimeBehavior=convertToNull","root","");
            PreparedStatement ps = (PreparedStatement) con.prepareStatement("INSERT INTO customer (customer_ip, customer_name, customer_email, customer_pass, customer_country, customer_city, customer_contact, customer_address, customer_gender, customer_image) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
            
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String password_repeat = req.getParameter("password_repeat");
            String country = req.getParameter("country");
            String city = req.getParameter("city");
            String contact = req.getParameter("contact");
            String address = req.getParameter("address");
            String gender = req.getParameter("gender");
            
            InetAddress localhost = InetAddress.getLocalHost();
            String ip = (localhost.getHostAddress()).trim();
            
            if(password.equals(password_repeat)){
                ps.setString(1, ip);
                ps.setString(2, name);
                ps.setString(3, email);
                ps.setString(4, password);
                ps.setString(5, country);
                ps.setString(6, city);
                ps.setString(7, contact);
                ps.setString(8, address);
                ps.setString(9, gender);
                ps.setString(10, fileName);
                ps.executeUpdate();
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Registration Successful.');");
                out.println("</script>");
                res.sendRedirect("user_login.jsp");
            }
            else{
                HttpSession session = req.getSession();
                session.setAttribute("isPasswordMatched", "false");
                res.sendRedirect("user_register.jsp");
            }
        }catch(Exception ex){
            ex.printStackTrace();
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
