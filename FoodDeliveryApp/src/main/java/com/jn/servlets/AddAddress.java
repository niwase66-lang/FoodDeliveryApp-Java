package com.jn.servlets;

import java.io.IOException;

import com.jn.daoimpl.AllAddressDAOImpl;
import com.jn.models.AllAddress;
import com.jn.models.Users;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/callAddAddress")
public class AddAddress extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		try {
			
			Users user = (Users)session.getAttribute("user");
			int userId = user.getUserId();
			
			String addressType = req.getParameter("addressType");
			
			String houseNo = req.getParameter("houseNo");
			String streetName = req.getParameter("streetName");
			String district = req.getParameter("district");
			String state = req.getParameter("state");
			String pincode = req.getParameter("pincode");
			
			String address=houseNo+", "+streetName+", "+district+", "+state+"- "+pincode;
			
			String contactNumber = req.getParameter("contactNumber");
			
			AllAddress allAddress = new AllAddress( userId, address, addressType,contactNumber);
		
			
			AllAddressDAOImpl allAddressImpl = new AllAddressDAOImpl();
			
			 allAddressImpl.addAddress(allAddress);
			 
			 RequestDispatcher rd = req.getRequestDispatcher("callRestaurantsServlet");
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
}
