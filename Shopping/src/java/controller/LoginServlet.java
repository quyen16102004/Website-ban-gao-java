package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import data.dao.Database;
import model.User;
import model.Cart;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("title", "Login Page");
        request.getRequestDispatcher("./views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String emailphone = request.getParameter("emailphone");
        String password = request.getParameter("password");

        User user = Database.getUserDao().findUser(emailphone, password);

        HttpSession session = request.getSession();

        if (user == null) {
            session.setAttribute("error_login", "Your information is incorrect!");
            response.sendRedirect("login");
            return;
        }

        if ("admin".equals(user.getRole())) {
            session.setAttribute("user", user);
            response.sendRedirect("admin");
            return;
        }

        
        User oldUser = (User) session.getAttribute("user");
        if (oldUser != null && oldUser.getId() != user.getId()) {
            List<Cart> oldCart = (List<Cart>) session.getAttribute("cart_" + oldUser.getId());
            if (oldCart != null) {
                oldCart.clear(); 
            }
        }

        
        session.removeAttribute("error_login");
        session.setAttribute("user", user);

        
        String cartKey = "cart_" + user.getId();
        if (session.getAttribute(cartKey) == null) {
            session.setAttribute(cartKey, new ArrayList<Cart>());
        }

        response.sendRedirect("home");
    }
}
