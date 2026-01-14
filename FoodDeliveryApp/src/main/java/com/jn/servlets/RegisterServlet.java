package com.jn.servlets;

import java.io.IOException;

import com.jn.daoimpl.UsersDAOImpl;
import com.jn.models.Users;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/callRegister")
public class RegisterServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		try {

			String firstName = req.getParameter("firstName");
			String lastName = req.getParameter("lastName");
			String userName=firstName+" "+lastName;
			String address = req.getParameter("address");
			String email = req.getParameter("email");
			String mobileNum = req.getParameter("mobileNum");
			String password = req.getParameter("password");
			String confirmPassword = req.getParameter("confirmPassword");

			UsersDAOImpl usersImpl = new UsersDAOImpl();

			if(!usersImpl.isUserExistsByEmail(email)) {
				if(password.equals(confirmPassword)) {
					Users user=new Users(userName,mobileNum,email,password,address);
					usersImpl.addUser(user);
					req.setAttribute("registerSuccess", true);
					RequestDispatcher rd = req.getRequestDispatcher("Register.jsp");
					rd.forward(req, resp);
				}
				else {
					req.setAttribute("isPasswordMatch", false);
					RequestDispatcher rd = req.getRequestDispatcher("Register.jsp");
					rd.forward(req, resp);
				}


			}
			else {
				req.setAttribute("isUserExist", false);
				RequestDispatcher rd = req.getRequestDispatcher("Register.jsp");
				rd.forward(req, resp);
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
