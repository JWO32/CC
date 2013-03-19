<%@ page language="java" import="java.util.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<jsp:include page="inc/header.jsp" />

<div id="header">
	<div id="title_banner">
		<h1>Comet Chaser!</h1>
	</div>
	<div id="menutabs">
	<jsp:include page="inc/tab-menu.jsp" />
	</div>
</div>

<body>
<script type="text/javascript" src="http://api.maps.yahoo.com/ajaxymap?v=3.8&appid=4Cypy_nV34GWh6Ovf0RgDtnWEil8bqYewseU0Ys4ofBa84WwGD.Zs1ek6DWw6.PHBQ17"></script>

<div id="main_content">
	<h3>Comments Map</h3>
	
    <div id="map"></div>
	
    <div id="comment">
    <fieldset>
    <form id="form" method="post" action="postcomment" onsubmit="return saveData(this)">
        <p>
          <label for="username">Username</label>
          <input type="text" name="username" id="username">
          <input type="hidden" name="lat" id="lat">
          <input type="hidden" name="lng" id="lng">
        </p>
        <p><label for="textarea">Comment:</label>
          <textarea name="comment" id="comment" cols="45" rows="5"></textarea>
        </p>
        <p align="right">
          <input type="submit" name="button" id="button" value="Post">
        </p>
       </form>           
      </fieldset>
	</div>
	</div>
	<jsp:include page="inc/footer.jsp" />
     	
	<script type="text/javascript">
	if(navigator.geolocation) {
    	var map = new YMap(document.getElementById('map')); 
    	
    	// Add the zoom control. Long specifies a Slider versus a "+" and "-" zoom control
    	map.addZoomLong();

		// Add the pan control
		map.addPanControl();
	
		// Add map type control
		map.addTypeControl();
	
		// Default map to satellite (YAHOO_MAP_SAT) -- other opts: YAHOO_MAP_HYB, YAHOO_MAP_REG
		map.setMapType(YAHOO_MAP_REG);
        
		//get current location
    	navigator.geolocation.getCurrentPosition(foundlocation,nolocation);
    	      
    	function foundlocation(position){
        	latitude = position.coords.latitude;
    		longitude = position.coords.longitude; 	
    		var coords = new YGeoPoint(latitude,longitude);
    		map.drawZoomAndCenter(coords,6);  
    		
    		//Add other comments locations
    		function createMarker(point, number)
    		{    			
    			var marker = new YMarker(point);		
    			var html = number;
    			YEvent.Capture(marker, EventsList.MouseClick, function(){marker.openSmartWindow(html);});
    			return marker;
    		};    
    		<% 
    		String username="root";
    		String password="";
    		String url="jdbc:mysql://localhost:3306/comet";
    		try{
    			String driver="com.mysql.jdbc.Driver";
    			Class.forName(driver).newInstance();
    			Connection conn;
    			conn = DriverManager.getConnection(url, username,password);
    			Statement s = conn.createStatement ();
    			s.executeQuery ("SELECT * from markers order by time");
    			ResultSet rs = s.getResultSet ();
    			int count = 0;
    			while (rs.next ()) {
    				String name=rs.getString("name");
    				float lat = rs.getFloat("lat");  
    				float lng = rs.getFloat("lng");
    				String comment=rs.getString ("comment");
    				String time=rs.getString("time");
    				String text="var marker= createMarker(point ,"+"\"<b>"+name+"</b><br/>"+comment+"<br/><br/>"+time+"\");\n";
    				out.print("var point = new YGeoPoint("+lat+","+lng+");\n");
    				out.print(text);
    				out.print("map.addOverlay(marker);\n");
    				out.print("\n");
    			}
    			rs.close ();
    			s.close ();
    		}
    		catch(Exception ee){
    			System.out.println(ee.toString());	
    		}%> 
    		
    		//Add current location
    		var myMarker = new YMarker(coords, createIMarkerImage());
    		var myMarkerContent = "<b>I'm here!</b>";
    		YEvent.Capture(myMarker, EventsList.MouseClick,
    		function(){
    				myMarker.openSmartWindow(myMarkerContent);
    				});
    		map.addOverlay(myMarker);
    		//specify the image of your location
    		function createIMarkerImage(){  
            	var myImage = new YImage();  
            	myImage.src="http://l.yimg.com/a/i/us/tr/fc/map/nightlife_bubble_w.png";
            	myImage.size = new YSize(35,35);  
            	myImage.offsetSmartWindow = new YCoordPoint(5,5);  
            	return myImage;  
        	}
    		
    		
    	}      
   		function nolocation(error){
			var map = new YMap(document.getElementById('map')); 
			map.addTypeControl(); 
			map.setMapType(YAHOO_MAP_REG);
    		alert("Location not found.");
    		// Display the map centered on a geocoded location
    		map.drawZoomAndCenter("London, UK", 6);    
    		}
   		}
	else{
		var map = new YMap(document.getElementById('map')); 
		map.addTypeControl(); 
		map.setMapType(YAHOO_MAP_REG);
    	alert("Geolocation API is not supported in your browser.");  
    	// Display the map centered on a geocoded location
    	map.drawZoomAndCenter("London, UK", 6);
	}	
	function saveData(form){
		form.lat.value=latitude;
		form.lng.value=longitude;
		return true; 	
    }
	</script>   	


