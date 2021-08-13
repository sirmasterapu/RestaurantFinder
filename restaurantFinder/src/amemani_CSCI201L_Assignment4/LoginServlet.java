package amemani_CSCI201L_Assignment4;

import java.io.IOException;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/Login")
public class LoginServlet extends HttpServlet {
	
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	
    	String userName = req.getParameter("lusername");
    	String passHash = req.getParameter("lpassword");
 
    	//checking if the username is null 
    	if(userName == null) {
    		resp.sendRedirect("/");
    		return;
    	}
    	//force Driver to work statement
    	try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	try {
	    	Connection conn = null; // Establish connection to database
			ResultSet rs = null; // What comes back from a select statement
			PreparedStatement ps = null;
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/factory?serverTimezone=UTC", "root", "ykYFXD.83A");
			//System.out.println("MaDE A CONNECTION");
			ps = conn.prepareStatement("SELECT * FROM Authentication WHERE Username = ?");
			ps.setString(1, userName); // set first variable in prepared statement
			rs = ps.executeQuery();
			rs.next();
			
			if(!passHash.equals(rs.getString("Password"))) {
				throw new SQLException();
			}
			
			//int userID = rs.getInt("userID");
			
			HttpSession session = req.getSession();
			//System.out.println("setting userID to " + userID);
           // session.setAttribute("userID", userID);
            session.setAttribute("userName", userName);
			RequestDispatcher dispatcher = req.getRequestDispatcher("/homePage.jsp");
            dispatcher.forward(req, resp);

			
    	} catch (SQLException sqle) {
			System.err.println("sqle: " + sqle.getMessage());
			
			req.setAttribute("message", "javascript/loginerror.js");
            RequestDispatcher dispatcher = req.getRequestDispatcher("index.jsp");
            dispatcher.forward(req, resp);
			
		}
    }
}
