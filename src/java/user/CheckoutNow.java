/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package user;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author SA
 */
@WebServlet("/checkoutNow")
public class CheckoutNow extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        HttpSession session = req.getSession();
        
        
        String co_method = req.getParameter("method_t");
         String co_price = req.getParameter("method_price");


           RequestDispatcher rd1 = req.getRequestDispatcher("/user_login.jsp");
         RequestDispatcher rd2 = req.getRequestDispatcher("/CheckoutCard.jsp");
         RequestDispatcher rd3= req.getRequestDispatcher("/CheckoutCash.jsp");
        try {
            synchronized(session){
                String loggedIn = (String) session.getAttribute("username");
                if(loggedIn != null){
                    if(co_method.equals("Cash")){
                    rd3.forward(req, resp);
                    }else{
                    rd2.forward(req, resp);
                    }
                }else{
                    rd1.forward(req, resp);
                }
            }
        } catch (Exception e) {
        }
    }
    
}
