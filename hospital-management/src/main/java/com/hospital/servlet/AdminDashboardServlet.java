package com.hospital.servlet;

import com.hospital.dao.AdminDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Integer adminId = (session != null) ? (Integer) session.getAttribute("adminId") : null;

        if (adminId == null) {
            resp.sendRedirect("login");
            return;
        }

        req.setAttribute("summary", new AdminDAO().getDashboardSummary());
        req.getRequestDispatcher("/adminDashboard.jsp").forward(req, resp);
    }
}
