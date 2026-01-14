package com.jn.servlets;

import java.io.IOException;
import java.util.List;

import org.apache.jasper.compiler.Node.GetProperty;

import com.jn.dao.RestaurantsDAO;
import com.jn.daoimpl.RestaurantsDAOImpl;
import com.jn.models.Cart;
import com.jn.models.Restaurants;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/callRestaurantsServlet")
public class ResturantsServlet extends HttpServlet {
	//	Cart cart;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
//		try {
			//	For guest registration


			String guest = req.getParameter("guest");

			if(guest!=null) {
				session.removeAttribute("user");
			}

			//	for login from restaurants page
			String loginFromRestaurantPage = req.getParameter("fromRestaurantForLogin");

			if(loginFromRestaurantPage!=null) {
				req.setAttribute("showLoginPopup", true);

			}

			//	for Profile popup
			if(req.getParameter("fromProfile")!=null) {
				req.setAttribute("profileOpen", true);
				//		from cart
				if(req.getParameter("fromCart")!=null) {
					RequestDispatcher rD = req.getRequestDispatcher("Cart.jsp");

					rD.forward(req, resp);
					//			from Menu
				}else if(req.getParameter("fromMenu")!=null) {
					RequestDispatcher rD = req.getRequestDispatcher("callMenu");
					req.setAttribute("restaurantId", 1);
					rD.forward(req, resp);
				}

			}

			if(req.getParameter("closeProfile")!=null) {
				req.removeAttribute("profileOpen");
				//		from cart
				if(req.getParameter("fromCart")!=null) {
					RequestDispatcher rD = req.getRequestDispatcher("Cart.jsp");

					rD.forward(req, resp);
					return;
				}
				//		from menu
				else if(req.getParameter("fromMenu")!=null) {
					RequestDispatcher rD = req.getRequestDispatcher("callMenu");
					req.setAttribute("restaurantId", 1);

					rD.forward(req, resp);
					return;
				}

			}


			RestaurantsDAO rest=new RestaurantsDAOImpl();

			List<Restaurants> allRestaurants = rest.getAllRestaurants();

			// for button active look
			req.setAttribute("from", "allRestaurants");

			req.setAttribute("allRestaurants", allRestaurants);

			RequestDispatcher rD = req.getRequestDispatcher("Restaurants.jsp");

			rD.forward(req, resp);




//		}
//		catch(Exception e) {
//			e.printStackTrace();
//			session.removeAttribute("user");
//			session.removeAttribute("restaurantId");
//			session.removeAttribute("cart");
//			RequestDispatcher rd = req.getRequestDispatcher("Error.jsp");
//			rd.include(req, resp);
//		}
	}

}
