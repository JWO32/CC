<jsp:include page="inc/header.jsp" />

<div id="header">
	<div id="title_banner">
		<h1>Comet Chaser!</h1>
	</div>
	<div id="menutabs">
	<jsp:include page="inc/tab-menu.jsp" />
	</div>
</div>
<div id="main_content">

  <script type='text/javascript'>
    function twitter(o)
    {      
  		var items = o.query.results.results;
  		var output = '';
  		var no_items=items.length;
	  	
  		for(var i=0;i<50;i++)
	  	{
	    	var title = items[i].from_user_name;
	    	var link = items[i].source; 
	    	var desc = items[i].text;
	    	var img = items[i].profile_image_url;
	    	var time = items[i].created_at;
	    	output += "<img src='"+ img +"'/>"+"<h3>"+title+"</h3>" + desc + "<br>"+time+"<br><hr/>";      
	  	}
  		
  		document.getElementById('twitter_results').innerHTML = output;  
  	}
    
   </script>
   
 
  
  <h1> Latest Twitter comments about the Comet </h1>
  <div id="twitter_results">
  
  </div>
  </div>
  
  <script src="https://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20twitter.search%20WHERE%20q%3D'Panstarrs'&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=twitter">
  </script> 
  <jsp:include page="inc/footer.jsp" />