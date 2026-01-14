package com.jn.servlets;

import java.io.IOException;

import com.jn.dao.UsersDAO;
import com.jn.daoimpl.UsersDAOImpl;
import com.jn.models.Users;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/callLoginServlet")
public class LoginServlet extends HttpServlet {

	//	@Override
	//	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	//		
	//		String userName = req.getParameter("username");
	//		String password = req.getParameter("password");
	//		
	//		UsersDAO usersImp = new UsersDAOImpl();
	//		
	//		if(usersImp.isUserExistsByEmail(userName)) {
	//			String ogPassword = usersImp.getPasswordByEmail(userName);
	//			if(password.equals(ogPassword)) {
	//				RequestDispatcher rd = req.getRequestDispatcher("callRestaurantsServlet");
	//				rd.forward(req, resp);
	////				System.out.println("Yes");
	//				return;
	//			}
	//			else
	//			{
	//				req.setAttribute("isPassword", false);
	//			}
	//		}
	//		else {
	//			req.setAttribute("isUserId", false);
	//		}
	//		
	//		RequestDispatcher rd = req.getRequestDispatcher("Login.jsp");
	//		rd.forward(req, resp);
	//	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		try {


			String userName = req.getParameter("username");
			String password = req.getParameter("password");

			UsersDAO usersImp = new UsersDAOImpl();


			String fromCart = req.getParameter("fromCart");
			String fromRestaurant = req.getParameter("fromRestaurant");


			if(usersImp.isUserExistsByEmail(userName)) {

				String ogPassword = usersImp.getPasswordByEmail(userName);

				if(password.equals(ogPassword)) {
					Users user = usersImp.getUserByEmail(userName);




					session.setAttribute("user", user);
					if(fromCart!=null) {
						RequestDispatcher rd = req.getRequestDispatcher("CheckOut.jsp");
						rd.forward(req, resp);
						return;
					}
					else {
						RequestDispatcher rd = req.getRequestDispatcher("callRestaurantsServlet");
						rd.forward(req, resp);
						//			System.out.println("Yes");
						return;
					}

				}
				else
				{
					req.setAttribute("isPassword", false);



					if(fromCart!=null) {
						RequestDispatcher rd = req.getRequestDispatcher("CheckOut.jsp");
						rd.forward(req, resp);
						return;
					}
					else if(fromRestaurant!=null){
						req.setAttribute("showLoginPopup", true);
						RequestDispatcher rd = req.getRequestDispatcher("callRestaurantsServlet");
						rd.forward(req, resp);
						//				System.out.println("Yes");
						return;
					}
					else{
						RequestDispatcher rd = req.getRequestDispatcher("Login.jsp");
						rd.forward(req, resp);
						//			System.out.println("Yes");
						return;
					}
				}
			}
			else {
				req.setAttribute("isUserId", false);
				if(fromCart!=null) {
					RequestDispatcher rd = req.getRequestDispatcher("CheckOut.jsp");
					rd.forward(req, resp);
					return;
				}
				else if(fromRestaurant!=null){
					req.setAttribute("showLoginPopup", true);
					RequestDispatcher rd = req.getRequestDispatcher("callRestaurantsServlet");
					rd.forward(req, resp);
					//			System.out.println("Yes");
					return;
				}
				else {

					RequestDispatcher rd = req.getRequestDispatcher("Login.jsp");
					rd.forward(req, resp);
					//		System.out.println("Yes");
					return;
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

		//		if(fromCart!=null) {
		//			RequestDispatcher rd = req.getRequestDispatcher("CheckOut.jsp");
		//			rd.forward(req, resp);
		//			return;
		//		}

		//		RequestDispatcher rd = req.getRequestDispatcher("Login.jsp");
		//		rd.forward(req, resp);
	}

}
