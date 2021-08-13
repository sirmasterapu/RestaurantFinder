
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SALEats | Login </title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
   <meta name="google-signin-client_id" content="600166206775-08gs2uv1m09apsqffa53oesvchm8ra35.apps.googleusercontent.com">
</head>
<body>
    <header>
        <h1> <span class="highlight">SalEats!</span></h1>
    </header>
    <script src="${message}"></script>
    <section id="login/signup">
        <div class="container">
            <div class="box">
                <form name="login" method="POST" action="Login">
                    <h3>Login</h3>
                    <input type="text" placeholder="username" name="lusername"><br>
                    <input type="password" placeholder="password" name="lpassword"><br>
                    <button class="button">login</button>
                    <div id="my-signin2"></div>
  <script>
    function onSuccess(googleUser) {
    	var email = googleUser.getBasicProfile().getEmail();
    	window.open("http://localhost:8080/amemani_CSCI201L_Assignment4/GoogleLogin?email=" + email, "_self");
    	

    }
    function onFailure(error) {
      console.log(error);
    }
    function renderButton() {
      gapi.signin2.render('my-signin2', {
        'scope': 'profile email',
        'width': 240,
        'height': 50,
        'longtitle': true,
        'theme': 'dark',
        'onsuccess': onSuccess,
        'onfailure': onFailure
      });
    }
  </script>

  <script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
             
        </form>
            </div>
            <div class="box">
                <form name="signup" method="POST" action="SignUpServlet">
                    <h4>Sign Up</h4>
                    <input type="text" placeholder="email" name="userEmail"><br>
                    <input type="text" placeholder="username" name="susername"><br>
                    <input type="password" placeholder="password" name="spassword"><br>
                    <input type="password" placeholder="confirm password" name="scpassword"><br>
                    <div style = "display: flex">
                     <input type="checkbox" name="confirmed" style = "flex-shrink: 4" value = "check">
       				 <span class="label-text fa-lg">
            		<span>I have read and agree to all terms and conditions given by SALEats</span>
       			 </span>
       			 </div>
                    <button class="button">sign up</button>                
                </form>
            </div>
        </div>
    </section>
</body>
</html>