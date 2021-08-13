package amemani_CSCI201L_Assignment4;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
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

import com.google.gson.Gson;
import com.google.gson.stream.JsonReader;

import amemani_CSCI201L_Assignment4.SearchServlet.Data;

/**
 * Servlet implementation class SearchDetailsServlet
 */
@WebServlet("/SearchDetails")
public class SearchDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String CLIENT_SECRET = "KLSWEhRuuJfTUCy7ij5wdPPX-wOPXUveqeqISmDufvOByXQ70H-iYuw3eyRdxWUzaSit2RgN7_T-BmBNgS6BWI1Pgj-G_LGJtw4JC7PGbeQyXMCyX482wFhq3Nl6XnYx";
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
           throws ServletException, IOException {
		
		String id = req.getParameter("restaurantId");
		Restaurant restaurant = null;
		HttpURLConnection connection = null;
		URL yelp = new URL("https://api.yelp.com/v3/businesses/"+id);
		connection = (HttpURLConnection) yelp.openConnection();
		connection.setRequestMethod("GET");
		connection.setRequestProperty("Authorization", "Bearer "+CLIENT_SECRET);
		BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		JsonReader testYelp = new JsonReader(in);
		Gson gson = new Gson();
		restaurant = gson.fromJson(testYelp, Restaurant.class);
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	String userName = (String) req.getSession().getAttribute("userName");
   
    	try {
	    	Connection conn = null; // Establish connection to database
			ResultSet rs = null; // What comes back from a select statement
			PreparedStatement ps = null;
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/factory?serverTimezone=UTC", "root", "ykYFXD.83A");
			//System.out.println("MaDE A CONNECTION");
			ps = conn.prepareStatement("SELECT * FROM Favorites WHERE Username = ? AND id =?");
			ps.setString(1, userName); // set first variable in prepared statement
			ps.setString(2,  id);
			rs = ps.executeQuery();
			PrintWriter out = resp.getWriter();
			
			out.print(restaurant.getDetails());
			
			if(rs.next()){
				out.print("|"+"true");
			}
			else{
				out.print("|"+"false");
			}
			out.flush();
			out.close();	

			
    	} catch (SQLException sqle) {
			System.err.println("sqle: " + sqle.getMessage());
			
		}
		
		
		}


	}

