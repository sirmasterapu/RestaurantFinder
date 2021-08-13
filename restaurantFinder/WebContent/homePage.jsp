
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SalEats | homePage</title>
    <link rel="stylesheet" type="text/css" href="css/homePageStyle.css">
    <script src="https://kit.fontawesome.com/389125cccb.js" crossorigin="anonymous"></script>	
    <script src="https://apis.google.com/js/platform.js" async defer></script>
   <meta name="google-signin-client_id" content="600166206775-08gs2uv1m09apsqffa53oesvchm8ra35.apps.googleusercontent.com">
</head>
<body>
    
   		 <div class = "headerContainer">
   		 	<div class = "headerTitle">
   		 	<button class="SalEatsHome" style = " border-width: 0px; font: normal 50px Brush Script MT;" onclick = "toHome()">
        	 <span class="highlight">SalEats!</span>
        	 </button>
        	 </div>
        	 <div class = "twoButtons">
        	 <button class="btn" onclick = "toHome()">Home</button>
        	 <button class="btn" id = "signin" onclick = "signIn()">Log In/Sign Up</button>
        	 <button  class = "btn" id="favorites" onclick = "showFavorites()" style="display: none">Favorites</button>
			<button class = "btn" id="logout" onclick="logout()" style="display: none">Logout</button>
        	 </div>
        	 <script>
        	 
        	 function toHome(){
        		 window.open("http://localhost:8080/amemani_CSCI201L_Assignment4/homePage.jsp", "_self"); 
        	 }
        	 function signIn(){
        		 window.open("http://localhost:8080/amemani_CSCI201L_Assignment4/index.jsp", "_self"); 
        	 }
        	 function logout(){
        		 var email = "<%= request.getSession().getAttribute( "userName" ) %>";
        		 var isGoogleUser = "<%= request.getSession().getAttribute( "isGoogleUser" ) %>";
        		 if(isGoogleUser=="no"){
        		 window.open("http://localhost:8080/amemani_CSCI201L_Assignment4/Logout", "_self"); 
        		 }
        		 else{ 
        			 var auth2 = gapi.auth2.getAuthInstance();
        			 auth2.signOut().then(function(){
        				 window.open("http://localhost:8080/amemani_CSCI201L_Assignment4/Logout", "_self");
        			 });
        			 
        			 
        		}
        	}
        	 function onLoad(){
        		 gapi.load('auth2', function(){
        			 gapi.auth2.init();
        		 });
        	 }
        	 window.onclick = function(event) {
        		  if (!event.target.matches('.dropbtn')) {
        		    var dropdowns = document.getElementsByClassName("dropdown-content");
        		    var i;
        		    for (i = 0; i < dropdowns.length; i++) {
        		      var openDropdown = dropdowns[i];
        		      if (openDropdown.classList.contains('show')) {
        		        openDropdown.classList.remove('show');
        		      }
        		    }
        		  }
        		}
        	 function dropDown(){
        		 document.getElementById("myDropdown").classList.toggle("show");
        	 }
        	 function showFavorites(order = ""){
        			if(order==""){
        				order = "AtoZ";
        			}
        		var homeImage = document.getElementById("homeImage");
      			homeImage.setAttribute("style", "display:none");
        		 var results = document.getElementById("results");
        		 results.setAttribute("style", "display: none");
        		 var oneRestaurant = document.getElementById("oneRestaurant");
        		 oneRestaurant.setAttribute("style", "display: none");
        		 var favoriteList = document.getElementById("favoriteList");
        		 favoriteList.setAttribute("style", "display: block");
        		 favoriteList.innerHTML = "";
        			 favoriteList.innerHTML += "<li class=\"result-item\" style=\" height: 150px; display: flex; list-style-type: none\">"+
        										 "<div class = \"topRow\"style=\"display: flex;\">" +
												"<div class = \"favoriteName\" style = \"color: #808080; font-size: 40px; padding-left: 30px; padding-right: 45px; padding-bottom: 50px; border-bottom: 1px; flex-grow: 2\">"+ "<%= request.getSession().getAttribute( "userName" ) %>" +"'s favorites: </div>"+
												"<div class = \"dropdown\">" +
													"<button onclick = \"dropDown()\" class = \"dropbtn\"><i class = \"fas fa-sort-amount-down\"></i>SortBy</button>"+
													"<div id = \"myDropdown\" class =\"dropdown-content\">" +
													"<a href = \"javascript: showFavorites('AtoZ')\">A to Z</a>"+
													"<a href = \"javascript: showFavorites('ZtoA')\">Z to A</a>"+
													"<a href = \"javascript: showFavorites('highestrated')\">Highest Rating</a>"+
													"<a href = \"javascript: showFavorites('lowestrated')\">Lowest Rating</a>"+
													"<a href = \"javascript: showFavorites('mostRecent')\">most Recent</a>"+
													"<a href = \"javascript: showFavorites('leastRecent')\">Least Recent</a>"+
												"</div>"+
												"</div>";
													
													
        		 var xhttp = new XMLHttpRequest();
	  			xhttp.open("GET","SearchFavorites?value="+order,false);
	  			xhttp.send();
	  			var arr = xhttp.responseText.split('\n'); 
	  			for(var i = 0; i < arr.length-1;i++){
  					var contents = arr[i].split("|");
  					var id = contents[0];
  					var name = contents[1];
  					var address = contents[2];
  					var url = contents[3];
  					var imageurl = contents[4];
  					favoriteList.innerHTML +="<li class=\"result-item\" style=\"display: flex; list-style-type: none\">"+
  										"<div class = \"imageResult\" style = \"flex-shrink: 2\">" +
  										"<input type = \"image\" onclick=\"getDetails('" + id+ "')\" src=\"" + imageurl+"\" alt=\"Restaurant Image\" id=\"result-image\" style = \"height:200px; width:200px;\" >" +
  										"</div>"+
  										"<div class = \"result-text\" style = \"display: flex; flex-direction: column; padding-left: 40px\">" +
  										"<div style=\"font-size: 20px; padding-bottom: 0px; padding-top:0px\">" + name + "</div>" +
  										"<div style=\"font-size: 14px; padding-bottom: 0px; padding-top:0px\">" + address + "</div>" +
  										"<div style=\"font-size: 14px; padding-bottom: 0px; padding-top:0px\"><a style=\"color:  grey\" href = \"" + url + "\">"+url+"</a></div>"+
  										"</div>"+
  										"</li>";
  				}
        	 }
        	 </script>
        	 <script async defer src="https://apis.google.com/js/platform.js?onload=onLoad"></script>
      	</div>
    <div><img src = "homeImage.jpg" name = "homeImage" id = "homeImage">
    </div>
  	<div class="container">
		<div class="item">
  		<input type = "text" id = "RestaurantInput">
  		</div>
  		<div class = "imageItem">
  			<script>
  			
  			 function getDetails(id){
  					var favoriteList = document.getElementById("favoriteList");
  					favoriteList.setAttribute("style", "display: none");
  					var results = document.getElementById("results");
  					results.setAttribute("style", "display: none");
  					var oneRestaurant = document.getElementById("oneRestaurant");
  					oneRestaurant.innerHTML="";
  					oneRestaurant.setAttribute("style", "display: block; display-style-type: none");
  					var xhttp = new XMLHttpRequest();
  	  				xhttp.open("GET","SearchDetails?restaurantId=" + id ,false);
  	  				xhttp.send();
  	  				var arr = xhttp.responseText.split('|'); 
  	  				var address = arr[0];
  	  				var phoneNum = arr[1];
  	  				var price = arr[2];
  	  				var rating = arr[3];
  	  				var url = arr[4];
  	  				var imageurl = arr[5];
  	  				var name = arr[6];
  	  				var favorite = arr[7];
  	  	
  					oneRestaurant.innerHTML+= "<li class=\"DetailsList\"style=\"color: #808080; font-size: 40px; padding-left: 30px;  padding-bottom: 100px; border-bottom: 1px #808080; list-style-type: none\">"+name+"<\li>";
  	  				oneRestaurant.innerHTML +="<li class=\"result-item\" style=\"display: flex; list-style-type: none\">"+
					"<div class = \"imageResult\" style = \"flex-shrink: 2\">" +
					"<a href=\""+url+"\">"+
					"<img src=\"" + imageurl+"\" alt=\"Restaurant Image\" id=\"result-image\" style = \"height:200px; width:200px; padding-left: 75px\" >" +
					"</a>"+
					"</div>"+
					"<div class = \"result-text\" style = \"display: flex; flex-direction: column; padding-left: 24px\">" +
					"<div style=\"font-size: 20px; padding-bottom: 0px; padding-top:0px\"><a style=\"color:  grey\">"+"Address: "+ address + "</a></div>" +
					"<div style=\"font-size: 20px; padding-bottom: 0px; padding-top:0px\"><a style=\"color:  grey\">"+"Phone No: "+ phoneNum + "</a></div>" +
					"<div style=\"font-size: 20px; padding-bottom: 0px; padding-top:0px\"><a style=\"color:  grey\">"+"Price: "+ price + "</a></div>" +
					"<div style=\"font-size: 20px; padding-bottom: 0px; padding-top:0px\"><a style=\"color:  grey\">"+"Rating: "+ RatingToString(rating) + "</a></div>" +
					"</div>"+
					"</li>";
					if(favorite=="false"){
  	  				oneRestaurant.innerHTML+= "<li class=\"FavoriteButton\"style=\"list-style-type: none\">"+
					"<button class = \"fbutton\" id = \"addfavbutton\" style = \"font-size: 12px; color: #808080; width: 80%; height: 40px; background-color: #FFC300\" onclick=\"addFav('" + id+ "')\"><i class = \"fas fa-star\"></i>"+ "Add to Favorites" + "</button>"+
					"<button class = \"fbutton\" style = \"font-size: 12px; color: #FFFFFF; width: 80%; height: 40px; background-color: #DE411F\"onclick = \"addRez('" + name+ "')\"><i class = \"Far fa-calendar-plus\"></i>"+ "Add to Reservations" + "</button>"+
						"</li>";
					}else{
						oneRestaurant.innerHTML+= "<li class=\"FavoriteButton\"style=\"list-style-type: none\">"+
						"<button class = \"fbutton\" style = \"font-size: 12px; color: #808080; width: 80%; height: 40px; background-color: #FFC300\"onclick = \"removeFav('" + id+ "')\"><i class = \"fas fa-star\"></i>"+ "Remove from Favorites" + "</button>"+
						"<button class = \"fbutton\" style = \"font-size: 12px; color: #FFFFFF; width: 80%; height: 40px; background-color: #DE411F\"onclick = \"addRez('" + name+ "')\"><i class = \"Far fa-calendar-plus\"></i>"+ "Add to Reservations" + "</button>"+
							"</li>";
					}
  					
  	  			
  	  		} 
  			 function addRez(name){
  				var isGoogleUser = "<%= request.getSession().getAttribute( "isGoogleUser" ) %>";
  				if(isGoogleUser=="no"){
  					alert("You have to be signed in with a a google account to add a reservation")
  					return;
  				}else{
  				var oneRestaurant = document.getElementById("oneRestaurant");
  				oneRestaurant.innerHTML+="<li class=\"result-item\" style=\" list-style-type: none\">"+
				"<div class = \"reservationForm\" style = \" width: 115.5%; display: flex\">" +
				"<input type = \"date\"    id= \"date\" >" +
				"<input type = \"time\"    id= \"time\">" +
				"</div>"+
				"<textarea rows = \"5\" cols = \"155\" name = \description\" id = \"description\">"+ "Enter Comments Here"+ 
	        	"</textarea>"+
	        	"<button class = \"fbutton\" style = \"font-size: 12px; color: #FFFFFF; width: 115.5%; height: 40px; background-color: #DE411F\"onclick = \"submitRez('" + id+ "')\"><i class = \"Far fa-calendar-plus\"></i>"+ "Sumbit Reservation" + "</button>"+
				"</li>";
				
  				}
  				
  			 }
  			 function sumbitRez(name){
  				 
  			 }
  			 function RatingToString(rating){
  				 rating = parseFloat(rating);
  				 var starString = "";
  			 	console.log(rating);
  			 	var i = 0;
  				 for(; i < rating-1;i++){
  					 starString+="<i class=\"fas fa-star\"></i>"
  				 }
  				 if(rating>i){
  					 starString+="<i class=\"fas fa-star-half\"></i>"
  				 }
  				 return starString;
  				
  				 
  			 }
  			 
  			 function addFav(id){
  				var xhttp = new XMLHttpRequest();
	  			xhttp.open("GET","FavoriteEditor?add=true&restaurantId=" + id ,false);
	  			xhttp.send();
	  			getDetails(id);
  			 }
  			function removeFav(id){
  				var xhttp = new XMLHttpRequest();
	  			xhttp.open("GET","FavoriteEditor?add=false&restaurantId=" + id ,false);
	  			xhttp.send();
	  			getDetails(id);
  			 }
  		function Search(){
  				var latitude = document.getElementById("latitude").value;
		    	 var longitude = document.getElementById("longitude").value;
		    	 var searchTerm = document.getElementById('RestaurantInput').value;
		    	 if(latitude==""||longitude==""||searchTerm==""){
		    	 alert("You did not fill out all required forms");
		    	 return;
		    	 }
  				var favoriteList = document.getElementById("favoriteList");
  				favoriteList.setAttribute("style", "display: none");
  				var radioButtonValues = document.getElementById('allButtons');
  				var inputs = radioButtonValues.getElementsByTagName("input");
  				var one = document.getElementById('oneRestaurant');
  				one.setAttribute("style","display: none");
  				var value;
  				console.log(value);
  				for (var i = 0; i < inputs.length; ++i) {
  				    if (inputs[i].checked) {
  				    	value = inputs[i].value;
  				    }
  				}
  				
  				
  				var xhttp = new XMLHttpRequest();
  				xhttp.open("GET","Search?value=" + value + "&latitude=" + latitude + "&longitude=" + longitude + "&restaurant=" +searchTerm,false);
  				xhttp.send();
  				
  				var results = document.getElementById("results");
  				results.innerHTML = "";
  				
  				
  				results.setAttribute("style", "display: block");
  				var homeImage = document.getElementById("homeImage");
  				homeImage.setAttribute("style", "display:none");
  				var arr = xhttp.responseText.split('\n'); 
  				var seccontents = arr[0].split("|");
  				results.innerHTML += "<li class=\"resultTerm\" style=\"display: flex; list-style-type: none; padding-left:40px; font: 16px; color: #808080\">"+"Results for "+arr[arr.length-1] + "</li>";
  				for(var i = 0; i < arr.length-1;i++){
  					var contents = arr[i].split("|");
  					
  					id = contents[0];
  					var name = contents[1];
  					var address = contents[2];
  					var url = contents[3];
  					var imageurl = contents[4];
  					results.innerHTML +="<li class=\"result-item\" style=\"display: flex; list-style-type: none\">"+
  										"<div class = \"imageResult\" style = \"flex-shrink: 2\">" +
  										"<input type = \"image\" onclick=\"getDetails('" + id+ "')\" src=\"" + imageurl+"\" alt=\"Restaurant Image\" id=\"result-image\" style = \"height:200px; width:200px;\" >" +
  										"</div>"+
  										"<div class = \"result-text\" style = \"display: flex; flex-direction: column; padding-left: 40px\">" +
  										"<div style=\"font-size: 20px; padding-bottom: 0px; padding-top:0px\">" + name + "</div>" +
  										"<div style=\"font-size: 14px; padding-bottom: 0px; padding-top:0px\">" + address + "</div>" +
  										"<div style=\"font-size: 14px; padding-bottom: 0px; padding-top:0px\"><a style=\"color:  grey\" href = \"" + url + "\">"+url+"</a></div>"+
  										"</div>"+
  										"</li>";
  					}
  						
  		}
  		
  		
  		</script>
  		<input type="image" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIIAAACCCAMAAAC93eDPAAAAb1BMVEX8AgT////8AAD9d3f+t7f9eXn9fn7//Pz+3Nz+5ub+7Oz+8vL9hYX+9/f+1NT8QUH8UlL9qqr9oKD9m5v8i4v8V1f9ycn8bW38MTH8Xl78IyP+zs78S0v9rq78HR38Zmb9vb38Kir9lZX8FRT8OztB9CKeAAAE9UlEQVR4nO2ca3uqMAyAIaIgIAoyxAt4/f+/8dTpRlp7SQXk2Xnot23QvqZpkiaZjusGnpdml0ue53Ecz55j+jomrcbvNGxytk6er7PK84rEdx23gkHHl+sEAM6AAyB1vEEJGMNmeITJiDAijAgjwogwIowI/x1CE3MNgvBc+7rbXbvCsEK4r7icVftw4d5HGBTprGyNYYHAVtqmoe/yw5+vV+0gyAgAdR6I6z/GIjleWzBQEQAuoXT9xwiO7wuChgAQRxqA+0gO70JQEABuhQHgrhTrNxkICAAb3R40Y39+i8GMwLSABMBGdHiHwYgAUFEJ2GZM3mAwIQB4dALGMLNnMCDIZbAIiqIInjZSGCtrBj2CTA+C9dePl6qP2fwFz1ofDAgbcQFv1fiER4JCPK/z2pJBiwA34TQWS9EdsJ+3Cf/QydI+6BH4TxhtZJMziJxnsDwWOgSYcTMnKofIrCenEr6dGDQIAJxf8DQTQ8ltRmrFoEOIqQTs2XOAlXbZDQJcsXT3hg8GOxxLnDpCwJoQGUULW8RgJQYlAgDaXv9IiCmwHV13grBC9pciWCiREZl3grC2lStnHizMtBoBqXhFDHCR3Cx2QoUANZrvRpsP0uaVgm4alAjHZjpqnhy2aO/oYb0SAXlpqlA5c0qPI5UIKFginMjnS6fmJbqvUiAAdpI7MgI6E5f2CM2BoDs+HOFYXJZVCI2DCOmTISNNdxNKhPDvIxTDI3QghUYXzI769y2kjh0gIBdBR0BxVtreNCErQ44/IGteytsjpG/MhkX31R4ByZR6N+G8K/1OpUQ4oFCQaKFxtDnvwFnj+IO2E1y0aZFPVUdNSB9pN1U4NG+40y4QJmhCihg452pzp1Mj4IA4JIiBSwTQzbP2KoOOJcHWQY0vX5tuEEp8RTPlkAD26GmrrgwNApfo8reGvByWmY0y6m/WZzyrNqcoZDkCq6y4NsXBZdsWW6V0xbycXdZNi3DlU00XOQPAmc82WVaa9LmmCTe1u5cUP9hvJjxpRI64KQhi6tWvSh7invUTEm5uZJVjMSDwZv8pifiM2qJueSA+wEDtsp+mBHD9WgrxgzTesBFn3lxeKYr0J9gOwYEVrRYhMNADFjMCn20hD5tkE6EkUr4jB59uGyiFoXpvXvJl0PWBVh7LzEsyj84XBsj6QCoSAhxe6g4vo6odfsd8oj4QS6UAsR4iuZcJrryR8GlyoFdrd5pybfIoE0DJM9D0gV42Z4tMpRXTyNv+WG0oBX2g2Emb5oG7RZ5V3Af1k3SLvQa+kVP1wbKF4rt9YjnNU+/kZfnmfBW7F2DH78XCvBf2jSRC/+7Ln2+CPhh1svt2GjgL+mDaix46enB65FsfDDrZR1MRXyUyns1e+ppE+xBq5dBPaxXUQjipy+X31N0FDq8Pukp2Xw1mL3uhPpu99biJtjpUns3+2uzEi1CkqlD02Okn+m6VHPpsNhT1YS5n6LXfUbTVc+mNu9+WS9FWS1OBPXd9ir67kMih78ZTUR8k14vee1/5HoSoHACBryvIEpgf6ABGtzFpI8YnmpB/GeSJ5I/0QcMjoZ3Ic7ifacUGyCNfkS37VDc4QLlU5Qw/1pCuTgn/0Z74EWFEGBFGhBFhRBgRPomwcZKh/+0/c1hwP+g4+I7rBievyi55/P29D+2+54H8bRCzWZxf1qnn7RfuP6jtOhOgHEeuAAAAAElFTkSuQmCC" id="searchIcon" onCLick = "Search()" />
 		
  		</div>
  	
  		<div class="allbuttonContainer" id = "allButtons">
  			<div class = "tworadioButton">
  				<div class = "radioButton">
   					<input type="radio" id="filter" name="filter" value="best_match">
					<label class ="greyed">Best Match</label><br>
				</div>
				<div class = "radioButton">
					<input type="radio" id="filter" name="filter"  value="rating">
					<label class="greyed">Rating</label><br>
				</div>
			</div>
			<div class = "tworadioButton">
				<div class = "radioButton">
					<input type="radio" id="filter" name="filter"  value="review_count">
					<label class="greyed">Review Count</label>
				</div>
				<div class = "radioButton">
					<input type="radio" id="filter" name="filter"  value="distance">
					<label class="greyed">Distance</label>
				</div>
			</div>
        </div>
	</div>
	<div class="container">
  		<div class="smallerItem">
   		 <input type="number" placeholder = "Latitude" id="latitude">
   		  </div>
   		 <div class="smallerItem">
          <input type="number" placeholder = "Longitude" id = "longitude">
          </div>  
          <button class = "button" onClick = "showMap()"><i class="fas fa-map-marker-alt" ></i> Google Maps! (Drop a pin!)</button>
 
	</div>
		<ul id = "favoriteList" style = "display: none; list-style-type: none"></ul>
		<ul id = "oneRestaurant" style = "display: none; display-style-type: none"></ul>
		<ul id = "results" style = "display: none; list-style-type: none;"></ul>
		<div id="mapModal">
			<div id="modal-content">
    			<script>
    			
				      var map;
				      var markers = [];
				      var mapModal = document.getElementById("mapModal");
				      var latitudeBox = document.getElementById("latitude");
				      var longitudeBox = document.getElementById("longitude");
				      function showMap(){
				    	  mapModal.style.display = "inline";
				      }
				      function initMap() {
				      	map = new google.maps.Map(document.getElementById('modal-content'), {
				        	center: {lat: 34.021, lng: -118.287},
				        	zoom: 8
				        });
				      	map.addListener('click', function(e) {
				      	    placeMarkerAndPanTo(e.latLng, map);
				      	}); 
				      }
				      
				      function placeMarkerAndPanTo(latLng, map) {
				    	
				      	var marker = new google.maps.Marker({
				    		position: latLng,
				      		map: map
				    	});
				      	if(markers !== undefined && markers.length != 0){
				      		var markerToRemove = markers.pop();
				      		markerToRemove.setMap(null);
				      	}
				      	markers.push(marker);
				    		map.panTo(latLng);
				    	}
				      window.onclick = function(event) {
					  	if (event.target == mapModal) {
							mapModal.style.display = "none";
							let currentMarker = markers.pop();
							latitudeBox.value = currentMarker.getPosition().lat();
							longitudeBox.value = currentMarker.getPosition().lng();
						}
					  }
			    </script>
			    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA4fqrqcFNjjmUH8jxhmjDrCFDTSgeRol0&callback=initMap"></script>
  			</div>
		</div>
   		<script>
			window.onload = function loggedIn(){
				var signInButton = document.getElementById("signin");
				var favoritesButton = document.getElementById("favorites");
				var logoutButton = document.getElementById("logout");
				var userName = "<%= request.getSession().getAttribute( "userName" ) %>";
				
				if(userName!="null"){
					signInButton.style.display = "none"
					favoritesButton.style.display = "inline"
					logoutButton.style.display = "inline"
				}
			}
		</script>
	</body>
</html>
		