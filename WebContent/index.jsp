<!doctype html>
<head>

<script src="http://yui.yahooapis.com/3.8.1/build/yui/yui-min.js"></script>

<!--<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>-->

</head>
<body>
<div id="header">
	<div id="title_banner">
		<h1>Comet Chaser!</h1>
	</div>
	<div id="menutabs">

	</div>
</div>

<div id="main_content">
<h1>Welcome to Comet Chaser</h1>

<p>From the 12th of March, Comet PANSTARRS is set to be visible from the Northern Hemisphere!</p>

<p>You can use Comet Chase to help you find where to look and see rare event and join our community of observers to shout out what you see!</p>

<script type="text/javascript">
//Download the latest comet details from Wolfram Alpha
//
YUI().use("io-base", "datasource-get", "datatype-xml", "dataschema-xml", "node", function (Y) 
{
	var baseUri = 'http://api.wolframalpha.com/v2/query?';
	var query = 'input=comet%20PANSTARRS';
	var dataFormat = 'format=image,plaintext';
	var apiKey = 'appid=8YE6TK-X5TAH287JP';

	baseUri = baseUri + apiKey +'&'+ query + '&' +dataFormat;
	
	var request = Y.io('XMLFetch', {
        method:"GET",
        xdr: {
            dataType:'xml' 
        },      
        on:
            {
                success:function(id, o) 
                {
                	var xmlDoc =  Y.DataType.XML.parse(o.responseText,
                			schema = {
                			resultListLocator: "//queryresult/pod",
                			resultFields: [{key: "text", locator: "plaintext"}]
                			}, 
                	data_out = Y.DataSchema.XML.apply(schema, xmlDoc));
                	
                	var pods = xmlDoc.getElementsByTagName('plaintext');
                	var cometDetails = Y.one('#current_details');
                	
                	cometDetails.setHTML('<h3>Current Comet Details</h3>' + '<p>' + pods[2].textContent + '</p>');
                	cometDetails.append('<p>'+pods[3].textContent+'</p>');
                	cometDetails.append('<p>'+pods[4].textContent+'</p>');
                	
                },
                failure:function(id, o) 
                {
                	alert('Failure: '+e.response);
                }
            }
        }
    );	
});

</script>

<div id="current_details">


</div>

</div>
</body>
</html>