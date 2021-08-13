package amemani_CSCI201L_Assignment4;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Logout
 */
@WebServlet("/Logout")
public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
		HttpSession session = req.getSession();
		//System.out.println("setting userID to " + userID);
       // session.setAttribute("userID", userID);
        session.setAttribute("userName", null);
        session.setAttribute("isGoogleUser", "no");
		RequestDispatcher dispatcher = req.getRequestDispatcher("/homePage.jsp");
        dispatcher.forward(req, resp);
	}
}

