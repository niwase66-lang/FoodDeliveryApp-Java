package com.jn.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.jn.models.Cart;
import com.jn.models.CartItem;
import com.jn.util.DBConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/callingCartServlet")
public class CartServlet extends HttpServlet {

	private final String GET_ITEM_BY_ID="SELECT * FROM MENU WHERE ITEM_ID=?";
	private int itemId;
	private String action;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		try {

			action=req.getParameter("action");
			itemId = Integer.parseInt(req.getParameter("itemId"));
			int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
			//	int itemQuantity = Integer.parseInt(req.getParameter("qty"));


			Cart cart = (Cart)session.getAttribute("cart");
			Integer oldRestaurantId=(Integer)session.getAttribute("restaurantId");
			if(oldRestaurantId==null){
				oldRestaurantId=-1;
			}

			System.out.println(restaurantId+" "+oldRestaurantId);

			System.out.println(cart);
			if(cart==null || restaurantId!=oldRestaurantId ) {
				System.out.println("new one ");
				cart = new Cart();
				session.setAttribute("cart", cart);
				session.setAttribute("restaurantId", restaurantId);

			}












			if(action.equals("add")) {
				addItem(cart);


			}
			else if(action.equals("update")) {
				String doing = req.getParameter("doing");
				System.out.println(doing);

				if(doing.equals("-")) {
					CartItem cartItem = cart.getCartItem(itemId);
					//			To prevent null pointer exception
					if(cartItem!=null) {

						if(cartItem.getItemQuantity()>1) {
							cartItem.setItemQuantity(cartItem.getItemQuantity()-1);
							cart.setCartItem(itemId, cartItem);
						}
						else {
							cart.removeCartItem(itemId);
						}
					}


				}

				else if (doing.equals("+")){
					addItem(cart);
				}
			}
			else if(action.equals("remove")) {
				cart.removeCartItem(itemId);
			}
			if(req.getParameter("callFromCartJsp")!=null) {
				RequestDispatcher rd = req.getRequestDispatcher("Cart.jsp");
				rd.forward(req, resp);
				return;
			}
			RequestDispatcher rd = req.getRequestDispatcher("callMenu");
			rd.forward(req, resp);



		}
		catch(Exception e) {
			e.printStackTrace();
			session.removeAttribute("user");
			session.removeAttribute("restaurantId");
			session.removeAttribute("cart");
			resp.sendRedirect("Error.jsp");
		}
	}

	public void addItem(Cart cart) {
		Connection connection = DBConnection.getConnection();
		try {
			System.out.println(action);
			PreparedStatement ps = connection.prepareStatement(GET_ITEM_BY_ID);

			ps.setInt(1, itemId);
			ResultSet rs = ps.executeQuery();
			//				System.out.println(rs);
			CartItem cartItem = extractCartItem(rs);
			cart.addCartItems(cartItem);
			//				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


	private static CartItem extractCartItem(ResultSet rs) throws SQLException {

		CartItem cart = new CartItem();
		rs.next();
		cart.setItemId(rs.getInt("item_id"));
		cart.setItemName(rs.getString("item_name"));
		cart.setItemPrice(rs.getDouble("item_price"));
		cart.setItemQuantity(1);
		//	    cart.setRestaurantName(rs.getString("restaurant_name"));
		cart.setRestaurantId(rs.getInt("restaurant_id"));

		return cart;
	}


}
