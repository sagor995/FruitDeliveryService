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
@WebServlet("/EditData")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
             maxFileSize=1024*1024*10,      // 10MB
             maxRequestSize=1024*1024*50)
public class EditData extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        try {
        String fileName="";   
        Part part=req.getPart("eproduct_image");
        fileName=extractFileName(part);
        String title = req.getParameter("eproduct_title");
        String type = req.getParameter("eproduct_type");
        String price = req.getParameter("eproduct_price");
        String descrition = req.getParameter("eproduct_des");
        String keyword = req.getParameter("eproduct_keyword"); 
        String pro_id = req.getParameter("edit_pro_id"); 

        
            if (fileName.equals("")) {
                fileName = req.getParameter("eproduct_image_old");
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
        
         Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fruit_ds","root","");
        PreparedStatement ps = con.prepareStatement("update products set product_type=?,product_title=?,product_price=?,product_description=?,product_image=?,product_keyword=? where product_id=?");

        ps.setString(1, type);
        ps.setString(2, title);
        ps.setString(3, price);
        ps.setString(4, descrition);
        ps.setString(5,fileName);
        ps.setString(6, keyword);
        ps.setString(7, pro_id);
        
        if (ps.executeUpdate() >0) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Data updated successfully.');");
            out.println("location='admin_pages/view_product.jsp';");
            out.println("</script>");
            //resp.sendRedirect("");
            //out.print(ps.getResultSet().toString());     
        }else{
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Data can't be updated. Try again later.');");
            out.println("location='admin_pages/edit_product.jsp';");
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
