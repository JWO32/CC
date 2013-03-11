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
                	// Can't get a YUI XML datascheme to automatically parse the XML into an array
                	// Will have to set about it the old fashioned way
                	//
                	var xmlDoc =  Y.DataType.XML.parse(o.responseText);
                	var cometDetails = xmlDoc.getElementsByTagName('plaintext');
                	var imageDetails = xmlDoc.getElementsByTagName('img');
                	var cometDetailsHTML = Y.one('#current_details');
                	
                	// wolfram alpha XML is very badly formed and not very intuitive
                	// so with little time for a fancy solution, I'll extract the bits I need manually
                	//
                	var locationDetails = cometDetails[0].textContent;
                	var physicalDetails = cometDetails[1].textContent;
                	var discoveryDetails = cometDetails[2].textContent;
                	var positionDetails = cometDetails[4].textContent;
                	var nearSkyObjects = cometDetails[5].textContent;
                	var riseSetDetails = cometDetails[8].textContent;
                	
                	
                	
                	
                	//locationDetails = locationDetails.replace('|', ' ');
                	physicalDetails = physicalDetails.split('|');
                	
                	//physicalDetails = physicalDetails.replace('|', ' ');
                	positionDetails = positionDetails.replace('|', ' '); // Remove vertical bars from output     	
                	discoveryDetails = discoveryDetails.replace('|', ' ');
                	nearSkyObjects = nearSkyObjects.replace('|', ' ');
                	
                	cometDetailsHTML.append('<h3>Current Comet Details</h3>');
                	cometDetailsHTML.append('<h7>Downloaded from Wolfram Alpha!</h7>');
                	
                	cometDetailsHTML.append('<ul>');
                	for(var i = 0; i < imageDetails.length; i++)
               		{
                		cometDetailsHTML.append('<li><img src ="'+imageDetails[i].attributes[0].nodeValue+'"/></li>');
               		}
                	cometDetailsHTML.append('</ul>');
                	
                	
                	/*cometDetailsHTML.append('<img src ="'+imageDetails[0].attributes[0].nodeValue+'"/>');
                	cometDetailsHTML.append('<img src ="'+imageDetails[1].attributes[0].nodeValue+'"/>');
                	cometDetailsHTML.append('<img src ="'+imageDetails[2].attributes[0].nodeValue+'"/>');
                	cometDetailsHTML.append('<img src ="'+imageDetails[3].attributes[0].nodeValue+'"/>');
                	cometDetailsHTML.append('<img src ="'+imageDetails[4].attributes[0].nodeValue+'"/>');
                	cometDetailsHTML.append('<img src ="'+imageDetails[5].attributes[0].nodeValue+'"/>');  */
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