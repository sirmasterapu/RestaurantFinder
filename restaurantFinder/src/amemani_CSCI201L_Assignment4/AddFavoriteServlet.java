package amemani_CSCI201L_Assignment4;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddFavoriteServlet
 */
@WebServlet("/FavoriteEditor")
public class AddFavoriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName = (String) request.getSession().getAttribute("userName");
		String add = request.getParameter("add");
		String id = request.getParameter("restaurantId");
		Connection conn = null; // Establish connection to database
		PreparedStatement ps = null;
		//force driver
		
		//Inserting the new User into data base
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/factory?serverTimezone=UTC", "root", "ykYFXD.83A");
			if(add.compareTo("true")==0){
				ps = conn.prepareStatement("INSERT INTO Favorites (username, id) VALUES (?,?);");
			}
			else{
				ps = conn.prepareStatement("DELETE FROM Favorites WHERE username = ? AND id = ?;");
			}
			ps.setString(1, userName); // set first variable in prepared statement
			ps.setString(2, id);
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}



}
