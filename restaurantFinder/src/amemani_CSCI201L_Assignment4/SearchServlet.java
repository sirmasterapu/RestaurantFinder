package amemani_CSCI201L_Assignment4;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.stream.JsonReader;



/**
 * Servlet implementation class SearchServlet
 */
@WebServlet("/Search")

public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 private static final String CLIENT_SECRET = "KLSWEhRuuJfTUCy7ij5wdPPX-wOPXUveqeqISmDufvOByXQ70H-iYuw3eyRdxWUzaSit2RgN7_T-BmBNgS6BWI1Pgj-G_LGJtw4JC7PGbeQyXMCyX482wFhq3Nl6XnYx";
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
		String latitude = req.getParameter("latitude");
		String term = req.getParameter("restaurant");
		String longitude = req.getParameter("longitude");
		String buttonVal = req.getParameter("value");
		req.getSession().setAttribute("term", term);
		Data data = null;
		HttpURLConnection connection = null;
		if(buttonVal.compareTo("undefined")==0){
			buttonVal = "best_match";
		}
		URL yelp = new URL("https://api.yelp.com/v3/businesses/search?latitude="+latitude+"&longitude="+longitude+"&limit=10"+"&sort_by=" + buttonVal+"&term=" + term.replace(" ", "%20").replaceAll("[-’,!']",""));
		connection = (HttpURLConnection) yelp.openConnection();
		connection.setRequestMethod("GET");
		connection.setRequestProperty("Authorization", "Bearer "+CLIENT_SECRET);
		BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		//String response = new String();
		//for (String line; (line = in.readLine()) != null; response += line);
		//System.out.println(response);
		JsonReader testYelp = new JsonReader(in);
	Gson gson = new Gson();
	data = gson.fromJson(testYelp, Data.class);
	List<Restaurant> businesses = data.getList();
		PrintWriter out = resp.getWriter();
		for(int i = 0; i < businesses.size(); i++){
			out.println(businesses.get(i).combineResults());
		}
		out.print(term);
		out.flush();
		out.close();	
		
	}
	class Data {
		List<Restaurant> businesses;
		
		List<Restaurant> getList(){
			return businesses;
		}

		public void setData(List<Restaurant> restaurants) {
			businesses = restaurants;
			
		}
	}
		
}


