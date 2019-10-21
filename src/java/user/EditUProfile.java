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
import java.net.InetAddress;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
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
@WebServlet("/EditUProfile")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
             maxFileSize=1024*1024*10,      // 10MB
             maxRequestSize=1024*1024*50)
public class EditUProfile extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        com.mysql.jdbc.Connection con = null;
        try {
        String fileName="";   
        Part part=req.getPart("cc_image");
        fileName=extractFileName(part);
        
        String name = req.getParameter("cc_name");
        String email = req.getParameter("cc_email");
        String country = req.getParameter("cc_country");
        String city = req.getParameter("cc_city");
        String contact = req.getParameter("cc_contact"); 
        String address = req.getParameter("cc_address"); 
        String c_id = req.getParameter("cst_id"); 
        String gender = req.getParameter("cc_gender"); 
        String pass = req.getParameter("cc_password"); 
        
        

        
            if (fileName.equals("")) {
                fileName = req.getParameter("cc__image_old");
            }else{
                String relativeWebPath = "/fruit";
                String slash = "build";
               String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);
               absoluteDiskPath = absoluteDiskPath.replaceAll(slash, "");
               absoluteDiskPath = absoluteDiskPath.replace("\\\\", File.separator.toString());

               String savePath = absoluteDiskPath ; //specify your path here

                   File fileSaveDir=new File(savePath);
                   if(!fileSaveDir.exists()){
                       fileSaveDir.mkdir();
                   }
                
                part.write(savePath + "\\" + fileName);
            }
            
//        out.println(""+name);
//        out.println(""+email);
//        out.println(""+country);
//        out.println(""+city);
//        out.println(""+c_id);
//        out.println(""+contact);
//        out.println(""+address);
//        out.println(""+gender);
//        out.println(""+pass);
//out.println(""+fileName);
        
        InetAddress localhost = InetAddress.getLocalHost();
            String ip = (localhost.getHostAddress()).trim();
        HttpSession session = req.getSession();
         Class.forName("com.mysql.jdbc.Driver");
         con = (com.mysql.jdbc.Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/fruit_ds?zeroDateTimeBehavior=convertToNull","root","");
      PreparedStatement ps = (com.mysql.jdbc.PreparedStatement) con.prepareStatement("select * from customer where customer_id=?");
        ps.setString(1, c_id);
        
         ResultSet rs = ps.executeQuery();
                String passw = "";
                
                if(rs.next()){
                    passw = rs.getString("customer_pass");
                }
        if (pass.equals(passw)) {
            ps = (PreparedStatement)con.prepareStatement("update customer set customer_ip=?, customer_name=?, customer_email=?, customer_pass=?, customer_country=?, customer_city=?, customer_contact=?, customer_address=?, customer_gender=?, customer_image=? where customer_id=?");
            ps.setString(1, ip);
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, pass);
            ps.setString(5, country);
            ps.setString(6, city);
            ps.setString(7, contact);
            ps.setString(8, address);
            ps.setString(9, gender);
            ps.setString(10, fileName);
            ps.setString(11, c_id);
            ps.executeUpdate();
            
            
            
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Details Updated.');");
            out.println("location='index.jsp';");
            out.println("</script>");
            
            session.removeAttribute("username");
            session.invalidate();//remove all the data
        }else{
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Please use correct password.');");
            out.println("location='MyAccount.jsp';");
            out.println("</script>");
        }
        //PreparedStatement ps = con.prepareStatement("update customer set customer_ip=?, customer_name=?, customer_email=?, customer_pass=?, customer_country=?, customer_city=?, customer_contact=?, customer_address=?, customer_gender=?, customer_image=? where customer_id=?");

        
//        if (ps.executeUpdate() >0) {
//            out.println("<script type=\"text/javascript\">");
//            out.println("alert('Data updated successfully.');");
//            out.println("location='admin_pages/view_product.jsp';");
//            out.println("</script>");
//            //resp.sendRedirect("");
//            //out.print(ps.getResultSet().toString());     
//        }else{
//            out.println("<script type=\"text/javascript\">");
//            out.println("alert('Data can't be updated. Try again later.');");
//            out.println("location='admin_pages/edit_product.jsp';");
//            out.println("</script>");
//            //out.print(ps.getResultSet().toString());   
//        }
        
        
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
