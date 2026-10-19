package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DiscountServlet", urlPatterns = {"/display-discount"})
public class DiscountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        double discountPercent = Double.parseDouble(request.getParameter("discount"));
        
        // Công thức tính chiết khấu
        double discountAmount = price * discountPercent * 0.01;
        double discountPrice = price - discountAmount;
        
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head><title>Discount Result</title></head>");
            out.println("<body style='font-family: Arial, sans-serif; display: flex; justify-content: center; margin-top: 50px; background-color: #f8fafc;'>");
            out.println("<div style='background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); width: 400px;'>");
            out.println("<h2 style='color: #27ae60; text-align: center;'>Kết Quả Chiết Khấu</h2>");
            out.println("<p><strong>Product Description:</strong> " + description + "</p>");
            out.println("<p><strong>List Price:</strong> $" + price + "</p>");
            out.println("<p><strong>Discount Percent:</strong> " + discountPercent + "%</p>");
            out.println("<p><strong>Discount Amount:</strong> $" + discountAmount + "</p>");
            out.println("<p><strong>Discount Price:</strong> <span style='color: #27ae60; font-weight: bold;'>$" + discountPrice + "</span></p>");
            out.println("<br><a href='index.jsp' style='display: block; text-align: center; text-decoration: none; padding: 10px; background-color: #1b2a7a; color: white; border-radius: 4px;'>Quay lại</a>");
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}