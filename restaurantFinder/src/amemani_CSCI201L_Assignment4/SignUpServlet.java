package amemani_CSCI201L_Assignment4;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SignUpServlet
 */
@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	
    	String userName = req.getParameter("susername");
    	String passHash = req.getParameter("spassword");
    	String confirmPass = req.getParameter("scpassword");
    	String email = req.getParameter("userEmail");
    	String checked = req.getParameter("confirmed");
    	String properEmailContents[] = {".edu",".com",".org", ".net", ".gov"};
    	System.out.println(email);
    	
    		//checks to see if they checked the terms of Use box
		if(checked==null||userName==null||email==null){
			req.setAttribute("message", "javascript/termsOfUseError.js");
            RequestDispatcher dispatcher = req.getRequestDispatcher("index.jsp");
            dispatcher.forward(req, resp);
		}
    		boolean validEmail = false;
    		
    		for(int i = 0 ; i < 5; i++){
    			if(email.contains(properEmailContents[i])){
    				validEmail = true;;
    			}
    		}
    		if(!email.contains("@")){
    			validEmail = false;
    		}
    		
    		if(!validEmail){
    			req.setAttribute("message", "javascript/invalidEmailError.js");
                RequestDispatcher dispatcher = req.getRequestDispatcher("index.jsp");
                dispatcher.forward(req, resp);
    		}
    
    	try {
    		//confirms the passowrds
    		if(!passHash.equals(confirmPass)) {
    			req.setAttribute("message","javascript/confirmerror.js");
                RequestDispatcher dispatcher = req.getRequestDispatcher("index.jsp");
                dispatcher.forward(req, resp);
    		}

	    	Connection conn = null; // Establish connection to database
			PreparedStatement ps = null;
			//force driver 
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/factory?serverTimezone=UTC", "root", "ykYFXD.83A");
			//Inserting the new User into data base
			ps = conn.prepareStatement("INSERT INTO Authentication (Username,email, Password) VALUES (?,?, ?);");
			ps.setString(1, userName); // set first variable in prepared statement
			ps.setString(2, email);
			ps.setString(3, passHash);
			int addedrows = ps.executeUpdate();
			//send to homepage
			RequestDispatcher dispatcher = req.getRequestDispatcher("/homePage.jsp");
            dispatcher.forward(req, resp);
			
    	} catch (SQLException sqle) {
    		System.err.println("sqle: " + sqle.getMessage());
			req.setAttribute("message", "javascript/usertakenerror.js");
            RequestDispatcher dispatcher = req.getRequestDispatcher("index.jsp");
            dispatcher.forward(req, resp);
    	} 
    }
    
}
