package com.jn.servlets;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Map;

import com.jn.daoimpl.OrderDAOImpl;
import com.jn.daoimpl.OrderItemDAOImpl;
import com.jn.models.Cart;
import com.jn.models.CartItem;
import com.jn.models.Order;
import com.jn.models.OrderItem;
import com.jn.models.Users;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/callOrders")
public class Orders extends HttpServlet {


	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();

		try {

			//	From Request Obj
			String confirmedAddress = req.getParameter("confirmedAddress");
			Double grandTotal = Double.parseDouble(req.getParameter("grandtotal"));
			String payment = req.getParameter("payment");



			//	from session Obj
			Users user=(Users)session.getAttribute("user");
			int userId = user.getUserId();

			int restaurantId=(Integer)session.getAttribute("restaurantId");

			//	Hard Values
			String stauts="Placed";

			Timestamp currentDate=new Timestamp(System.currentTimeMillis());

			System.out.println();
			System.out.println(confirmedAddress+", "+grandTotal+", "+payment+", "+userId+", "+restaurantId+", "+stauts+", "+currentDate);

			//	setting details to obj
			Order order=new Order(userId,restaurantId,confirmedAddress,payment,stauts,currentDate,grandTotal);

			OrderDAOImpl orderImpl = new OrderDAOImpl();

			int orderId = orderImpl.createOrder(order);

			if(orderId!=0) {
				Cart cart = (Cart)session.getAttribute("cart");
				Map<Integer, CartItem> cartItems = cart.getItems();


				boolean isOrderConfirmed =false;
				for(CartItem cartItem : cartItems.values()) {
					int itemId = cartItem.getItemId();
					String itemName = cartItem.getItemName();
					int itemQuantity = cartItem.getItemQuantity();
					Double totalPrice = cartItem.getTotalPrice();

					//			setting details to obj
					OrderItem orderItem = new OrderItem(orderId,itemId,itemName,itemQuantity,totalPrice);

					OrderItemDAOImpl orderItemImpl = new OrderItemDAOImpl();

					isOrderConfirmed = orderItemImpl.addOrderItem(orderItem);

					System.out.println(isOrderConfirmed);
					System.out.println("runs");



				}
				if(isOrderConfirmed) {
					System.out.println("entered");
					session.removeAttribute("cart");
					Cart finalyCart =null;
					session.setAttribute("cart", finalyCart);
					session.removeAttribute("restaurantId");

					RequestDispatcher rd = req.getRequestDispatcher("OrderConfirm.jsp");
					rd.forward(req, resp);
				}

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
