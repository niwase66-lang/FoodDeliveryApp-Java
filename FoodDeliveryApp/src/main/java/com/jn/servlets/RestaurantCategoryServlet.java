package com.jn.servlets;

import java.io.IOException;
import java.util.List;

import com.jn.daoimpl.RestaurantsDAOImpl;
import com.jn.models.Restaurants;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/callCategory")
public class RestaurantCategoryServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		try {

			String filterType = req.getParameter("filterType");

			RestaurantsDAOImpl restaurantsImpl = new RestaurantsDAOImpl();
			if(filterType.equals("rating")) {
				List<Restaurants> allRestaurantsByRating = restaurantsImpl.getAllRestaurantsByRating();

				// for button active look
				req.setAttribute("from", "rating");

				req.setAttribute("allRestaurants", allRestaurantsByRating);

				RequestDispatcher rD = req.getRequestDispatcher("Restaurants.jsp");

				rD.forward(req, resp);
			}
			else if(filterType.equals("deliveryTime")) {
				List<Restaurants> allRestaurantsByDeliveryTime = restaurantsImpl.getAllRestaurantsByDeliveryTime();

				// for button active look
				req.setAttribute("from", "deliveryTime");

				req.setAttribute("allRestaurants", allRestaurantsByDeliveryTime);

				RequestDispatcher rD = req.getRequestDispatcher("Restaurants.jsp");

				rD.forward(req, resp);
			}



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
