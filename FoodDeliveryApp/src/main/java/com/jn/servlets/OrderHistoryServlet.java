package com.jn.servlets;

import java.io.IOException;
import java.util.List;

import com.jn.daoimpl.OrderDAOImpl;
import com.jn.models.Order;
import com.jn.models.Users;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/callOrderHistory")
public class OrderHistoryServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();

		try {


			Users user=(Users)session.getAttribute("user");
			int userId = user.getUserId();

			OrderDAOImpl orderImpl = new OrderDAOImpl();

			List<Order> ordersByUserId = orderImpl.getOrdersByUserId(userId);

			req.setAttribute("allOrders", ordersByUserId);

			RequestDispatcher rd = req.getRequestDispatcher("OrderHistory.jsp");
			rd.forward(req, resp);


		}
		catch(Exception e) {
			e.printStackTrace();
			session.removeAttribute("user");
			session.removeAttribute("restaurantId");
			session.removeAttribute("cart");
			RequestDispatcher rd = req.getRequestDispatcher("Error.jsp");
			rd.forward(req, resp);
		}
	}
}
