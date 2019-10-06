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
@WebServlet("/EditImages")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
             maxFileSize=1024*1024*10,      // 10MB
             maxRequestSize=1024*1024*50)
public class EditImages extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        try {

        String relativeWebPath = "/img";
         String slash = "build";
        String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);
        absoluteDiskPath = absoluteDiskPath.replaceAll(slash, "");
        absoluteDiskPath = absoluteDiskPath.replace("\\\\", File.separator.toString());
       
        String savePath = absoluteDiskPath ; //specify your path here
        
            File fileSaveDir=new File(savePath);
            if(!fileSaveDir.exists()){
                fileSaveDir.mkdir();
            }
        //out.println(""+savePath); 
        Part part=req.getPart("change_image");
        String fileName=extractFileName(part);
        part.write(savePath + "\\" + fileName);
        
        String img_type = req.getParameter("image_type");
        
        
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fruit_ds","root","");
        PreparedStatement ps = null;
        
        if (img_type.equals("Site Logo")) {
            ps = con.prepareStatement("update others set header_image = ? where id = 2 ");
            ps.setString(1,fileName);
        }else if(img_type.equals("Header Banner")){
            ps = con.prepareStatement("update others set ads_cover_image = ? where id = 2 ");
            ps.setString(1,fileName);
        }else if (img_type.equals("Center Banner")) {
            ps = con.prepareStatement("update others set ads_center_image = ? where id = 2 ");
            ps.setString(1,fileName);
        }
        
        
        
        if (ps.executeUpdate() >0) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('successfully updated');");
            out.println("location='admin_pages/edit_images.jsp';");
            out.println("</script>");
            //resp.sendRedirect("");
            //out.print(ps.getResultSet().toString());     
        }else{
            out.println("<script type=\"text/javascript\">");
            out.println("alert('can't be updated. Try again later.');");
            out.println("location='admin_pages/edit_images.jsp';");
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
