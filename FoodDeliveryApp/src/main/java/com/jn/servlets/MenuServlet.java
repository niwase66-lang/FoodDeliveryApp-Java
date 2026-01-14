package com.jn.servlets;

import java.io.IOException;
import java.util.List;

import com.jn.dao.MenuDAO;
import com.jn.daoimpl.MenuDAOImpl;
import com.jn.models.Menu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/callMenu")
public class MenuServlet extends HttpServlet {
	private int restaurantId;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();

		try {



			MenuDAO menuImpl = new MenuDAOImpl();
			System.out.println(req);
			if(req.getParameter("callFromCart")==null )  {
				restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
				req.setAttribute("restaurantId",restaurantId);
			}
			else {

				restaurantId=(Integer)session.getAttribute("restaurantId");
			}

			//	

			req.setAttribute("restaurantId", restaurantId);

			List<Menu> menuByRestaurantId = menuImpl.getMenuByRestaurantId(restaurantId);

			req.setAttribute("menuByRestaurantId", menuByRestaurantId);

			RequestDispatcher rd = req.getRequestDispatcher("Menu.jsp");
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
