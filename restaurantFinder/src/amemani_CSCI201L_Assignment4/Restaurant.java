package amemani_CSCI201L_Assignment4;

import java.util.Map;

public class Restaurant{
public Map<String, Double> coordinates;
public Location location;
public String name;
public String image_url;
public String url;
public String address;
public String rating;
public String id;
public int review_count;
public String price;
public String display_phone;
public Double distance;
	public Restaurant(Double distance, String display_phone,String price, Location location, String id,Map<String, Double> coordinates, String name, String image_url, String url, String rating, int review_count){
		this.location = location;
		this.id = id;
		this.coordinates = coordinates;
		this.name = name;
		this.image_url = image_url.substring(0,image_url.indexOf('?'));
		this.url = url;
		this.rating = rating;
		this.review_count = review_count;
		this.price = price;
		this.display_phone = display_phone;
		this.distance = distance;
	}
	public String combineResults(){
		
		
		return id+"|"+name+"|"+getAddress()+"|"+url.substring(0,url.indexOf('?'))+"|"+image_url;
		
	}
	public String getAddress(){
		String x = "";
		for(int i = 0; i < location.display_address.size();i++){
			x+=location.display_address.get(i);
			x+= " ";
		}
		return x;
	}
	
	public String getDetails(){
		return getAddress()+"|"+display_phone+"|"+ price+"|"+ rating+"|"+ url.substring(0,url.indexOf('?'))+"|"+ image_url+"|"+name;
	}

	
}
