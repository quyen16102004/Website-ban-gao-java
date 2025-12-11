/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Cart;

/**
 *
 * @author DIEM
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CheckoutServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // LẤY USER ĐANG ĐĂNG NHẬP
        model.User user = (model.User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // LẤY ĐÚNG GIỎ THEO USER
        String cartKey = "cart_" + user.getId();
        List<Cart> cartList = (List<Cart>) session.getAttribute(cartKey);

        // KIỂM TRA GIỎ RỖNG
        if (cartList == null || cartList.isEmpty()) {
            request.setAttribute("message", "❌ Giỏ hàng của bạn đang rỗng!");
            request.getRequestDispatcher("/views/cart.jsp").forward(request, response);
            return;
        }

        // TÍNH TỔNG TIỀN
        double totalAmount = 0;
        for (Cart c : cartList) {
            totalAmount += c.getTotalPrice();
        }

        // GỬI DỮ LIỆU RA TRANG XÁC NHẬN
        request.setAttribute("cartList", new java.util.ArrayList<>(cartList));
        request.setAttribute("totalAmount", totalAmount);

        // XÓA GIỎ HÀNG SAU KHI THANH TOÁN
        cartList.clear();
        session.setAttribute(cartKey, cartList);

        // CHUYỂN TRANG
        request.getRequestDispatcher("views/checkout-success.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.sendRedirect(request.getContextPath() + "/views/cart.jsp");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
