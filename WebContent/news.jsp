<!doctype html>
<head>
<title>Comet News!</title>
<script src="http://yui.yahooapis.com/3.8.1/build/yui/yui-min.js"></script>

</head>

<body>
<script type="text/javascript">

YUI().use("io-base", "json-parse", "data-schema-json", "node", function (Y) 
{
	var request = Y.io('FetchFeed/ypCometNews', 
	{
		method: 'GET',
		xdr: {
			dataType: 'json'
		},
		on:
			{
				success: function(tx, r)
				{
					var cometNews;
					var newsHTML;
					
					try
					{
						cometNews = Y.JSON.parse(r.responseText);
						
						var itemList = cometNews.value.items;
						newsHTML = Y.one('#News_Stories');
						
						for(var i = 0; i < itemList.length; i++)
						{
							newsHTML.append('<div class="news_item"');
							newsHTML.append('<h3>'+itemList[i].title+'</h3>');
							newsHTML.append('<p>'+itemList[i].description+'</p>');
							newsHTML.append('<p><a href="'+itemList[i].link+'" target="_blank">View Story</a></p>');
						}
						
					}catch(e)
					{
						alert('Could Not Parse Server Response');
						return;
					}
				},
				
				failure: function()
				{
					
				}
			
			}
		
	});
	
});

</script>

<div id="Main_Content">
<h1>Comet PANSTARRS Latest News</h1>
<p>A collection of news stories from a variety of sources!</p>

<div id="News_Stories">



</div>

</div>

</body>
</html>