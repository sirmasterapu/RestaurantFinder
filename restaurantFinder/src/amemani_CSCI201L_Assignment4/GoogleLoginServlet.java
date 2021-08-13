package amemani_CSCI201L_Assignment4;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class GoogleLoginServlet
 */
@WebServlet("/GoogleLogin")
public class GoogleLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
		//String userID= req.getParameter("userID");
		String email= req.getParameter("email");
		try {
    		//force Driver to work statement
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

	    	Connection conn = null; // Establish connection to database
			PreparedStatement ps = null;
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/factory?serverTimezone=UTC", "root", "ykYFXD.83A");
			ps = conn.prepareStatement("SELECT * FROM Authentication WHERE email = ?");
			ps.setString(1, email); // set first variable in prepared statement
			ResultSet rs = null; // What comes back from a select statement
			rs = ps.executeQuery();
			//no email was found
			if(rs.next()){
				HttpSession session = req.getSession();
				System.out.println("setting email to " + email);
	           session.setAttribute("userName", email);
	           session.setAttribute("isGoogleUser", "yes");
				
			}
			//this is an existing user
			else{
				ps = conn.prepareStatement("INSERT INTO Authentication (Username,email, Password) VALUES (?,?, ?);");
				ps.setString(1, ""); // set first variable in prepared statement
				ps.setString(2, email);
				ps.setString(3, "");
				int addedrows = ps.executeUpdate();
				System.out.println(addedrows);
			
			}
			
			RequestDispatcher dispatcher = req.getRequestDispatcher("/homePage.jsp");
			dispatcher.forward(req, resp);
			
    	} catch (SQLException sqle) {
    		System.err.println("sqle: " + sqle.getMessage());
    	}
	}


}
