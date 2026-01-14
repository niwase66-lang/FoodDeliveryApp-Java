package com.jn.servlets;

import java.io.IOException;

import com.jn.models.Users;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/callAddress")
public class AddressServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		try {



			String changeAddress = req.getParameter("changeAddress");



			Users user=(Users)session.getAttribute("user");
			int userId = user.getUserId();

			if(changeAddress!=null) {
				session.setAttribute("changeAddress", changeAddress);
				RequestDispatcher rd = req.getRequestDispatcher("CheckOut.jsp");
				rd.forward(req, resp);
				return;
			}
			else {
				System.out.println("reached");
				session.removeAttribute("changeAddress");



			}
			String currentAddress = req.getParameter("selectedAddress");
			if(currentAddress!=null) {
				user.setUserLocation(currentAddress);
				RequestDispatcher rd = req.getRequestDispatcher("CheckOut.jsp");
				rd.forward(req, resp);
			}
			else {
				String houseNo = req.getParameter("houseNo");
				String streetName = req.getParameter("streetName");
				String district = req.getParameter("district");
				String state = req.getParameter("state");
				String pincode = req.getParameter("pincode");
				String phNum = req.getParameter("phNum");
				String addressType = req.getParameter("addressType");
				currentAddress=houseNo+","+streetName+","+district+","+state+"-"+pincode;
				user.setUserLocation(currentAddress,userId,addressType,phNum);

				RequestDispatcher rd = req.getRequestDispatcher("CheckOut.jsp");
				rd.forward(req, resp);
			}



		}
		catch(Exception e) {
			e.printStackTrace();
			session.removeAttribute("user");
			session.removeAttribute("restaurantId");
			session.removeAttribute("cart");
			resp.sendRedirect("Error.jsp");
		}


	}

}
