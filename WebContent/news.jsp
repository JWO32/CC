<!doctype html>
<head>
<title>Comet News!</title>
<script src="http://yui.yahooapis.com/3.8.1/build/yui/yui-min.js"></script>

</head>
<body>

<script type="text/javascript">

YUI().use("io-base", "datasource-get", "datatype-xml", "dataschema-xml", "node", function (Y) 
{
	var request = Y.io('FetchFeed/ypCometNews', 
	{
		method: 'GET',
		xdr: {
			dataType: 'json'
		},
		on:
			{
				success: function()
				{
					
				},
				
				failure: function()
				{
					
				}
			
			}
		
	});
	
});

</script>


</body>
</html>