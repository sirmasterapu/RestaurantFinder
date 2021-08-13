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
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.stream.JsonReader;

/**
 * Servlet implementation class SearchFavoritesServlet
 */
@WebServlet("/SearchFavorites")
public class SearchFavoritesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String CLIENT_SECRET = "KLSWEhRuuJfTUCy7ij5wdPPX-wOPXUveqeqISmDufvOByXQ70H-iYuw3eyRdxWUzaSit2RgN7_T-BmBNgS6BWI1Pgj-G_LGJtw4JC7PGbeQyXMCyX482wFhq3Nl6XnYx";
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
           throws ServletException, IOException {
		
		String userName = (String) req.getSession().getAttribute("userName");
		String value = (String) req.getParameter("value");
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
			ps = conn.prepareStatement("SELECT * FROM Favorites WHERE Username = ?");
			ps.setString(1, userName); // set first variable in prepared statement
			rs = ps.executeQuery();
			ArrayList<Restaurant> restaurants = new ArrayList<Restaurant>();
			while(rs.next())
			{
				String id = rs.getString(2);
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
				restaurants.add(restaurant);
			}
			ArrayList<Restaurant> newList = new ArrayList<Restaurant>();
			int size = restaurants.size();
			if(value.compareTo("AtoZ")==0){
				for(int i = 0; i < size;i++){
					int smallestIndex = 0;
					for(int j = 0; j < restaurants.size(); j++){
						if(restaurants.get(j).name.compareTo(restaurants.get(smallestIndex).name)<0){
							smallestIndex = j;
						}
					}
					newList.add(restaurants.get(smallestIndex));
					restaurants.remove(smallestIndex);
				}
				
			}
			
			else if(value.compareTo("ZtoA")==0){
				for(int i = 0; i < size;i++){
					int biggestIndex = 0;
					for(int j = 0; j < restaurants.size(); j++){
						if(restaurants.get(j).name.compareTo(restaurants.get(biggestIndex).name)>0){
							biggestIndex = j;
						}
					}
					newList.add(restaurants.get(biggestIndex));
					restaurants.remove(biggestIndex);
				}
				
				
			}
			else if(value.compareTo("highestrated")==0){
				for(int i = 0; i < size;i++){
					int biggestIndex = 0;
					for(int j = 0; j < restaurants.size(); j++){
						if(Double.parseDouble(restaurants.get(j).rating)>Double.parseDouble(restaurants.get(biggestIndex).rating)){
							biggestIndex = j;
						}
					}
					newList.add(restaurants.get(biggestIndex));
					restaurants.remove(biggestIndex);
				}
				
			}
			else if(value.compareTo("lowestrated")==0){
				for(int i = 0; i < size;i++){
					int smallestIndex = 0;
					for(int j = 0; j < restaurants.size(); j++){
						if(Double.parseDouble(restaurants.get(j).rating)<Double.parseDouble(restaurants.get(smallestIndex).rating)){
							smallestIndex = j;
						}
					}
					newList.add(restaurants.get(smallestIndex));
					restaurants.remove(smallestIndex);
				}
				
			}
			else if(value.compareTo("mostRecent")==0){
				for(int i = restaurants.size()-1; i >= 0;i--){
					newList.add(restaurants.get(i));
				}
				
			}
			else if(value.compareTo("leastRecent")==0){
				for(int i = 0 ; i < restaurants.size(); i++){
					newList.add(restaurants.get(i));
				}
			}
			
			
			PrintWriter out = resp.getWriter();
			for(int i = 0; i < newList.size(); i++){
				out.println(newList.get(i).combineResults());
			}
			out.flush();	
			out.close();
			
			
    	} catch (SQLException sqle) {
			System.err.println("sqle: " + sqle.getMessage());
			
		}
		
		
		}


	}
