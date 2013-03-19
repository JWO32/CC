<jsp:include page="inc/header.jsp" />

<div id="header">
	<div id="title_banner">
		<h1>Comet Chaser!</h1>
	</div>
	<div id="menutabs">
	<jsp:include page="inc/tab-menu.jsp" />
	</div>
</div>

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
						newsHTML = Y.one('#news_stories');
						
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
					alert('Unable to display news');
				}
			
			}		
	});
	
});

</script>

<div id="main_content">
<h1>Comet PANSTARRS Latest News</h1>
<p>A collection of news stories from a variety of sources!</p>

<div id="news_stories">


</div>

</div>

<jsp:include page="inc/footer.jsp" />