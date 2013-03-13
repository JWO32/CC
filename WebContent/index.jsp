<!doctype html>
<head>
<title>Comet Chaser!</title>
<script src="http://yui.yahooapis.com/3.8.1/build/yui/yui-min.js"></script>

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

<p>You can use Comet Chaser to help you find where to look and see rare event and join our community of observers to shout out what you see!</p>


<div id='star_chart'>
<iframe width="500" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://lcogt.net/virtualsky/embed/?longitude=2.30&latitude=56.30&projection=equirectangular&meteorshowers=true&showstarlabels=true&live=true&az=260" allowTransparency="true"></iframe>
</div>

<script type="text/javascript">

var getLocation = function()
{
	if(navigator.geolocation)
	{
		navigator.geolocation.getCurrentPosition(getSkyMap);	
	}else
	{
		alert('Unable to your location: comet sky map unavailable');
	}
};

var getSkyMap = function(position)
{
	var lat = position.coords.latitude;
	var longi = position.coords.longitude;
	
	lat = lat.toString();
	longi = longi.toString();
	
	var latDegrees = lat.slice(0,2);
	var latMinutes = lat.slice(3,4);
	
	var longDegrees = longi.slice(0,2);
	var longMinutes = longi.slice(3,4);
	
	var ysLink = 'http://www.fourmilab.ch/cgi-bin/Yourhorizon?date=1&utc=2013%2F03%2F12+17%3A55%3A01&jd=2450859.37154&azimuth=V&azideg=250+&fov=55%B0&lat='+latDegrees+'%B0'+latMinutes+'%22&ns=North&lon='+longDegrees+'%B0'+longMinutes+'%22&ew=West&moonp=on&deep=on&deepm=3.0&consto=on&constn=on&limag=5.5&starn=on&starnm=3.0&starb=on&starbm=3.5&showmb=-1.5&showmd=6.0&terrain=on&terrough=0.7&scenery=on&imgsize=512&dynimg=y&fontscale=1.0&scheme=0&elements=+++C%2F2011+L4+%28PANSTARRS%29++++++Orbital+elements+by+G.+V.+Williams%0D%0AEpoch+2013+Mar.+9.0+TT+%3D+JDT+2456360.5++++++++++++++++++++++++++++++++++++++++++%0D%0AT+2013+Mar.+10.16839+TT++++++++++++++++++++++++++++++%0D%0Aq+++0.3015433++++++++++++%282000.0%29++++++++++++P+++++++++++++++Q++++++++++++++++++%0D%0Az++-0.0000420++++++Peri.++333.65160+++++%2B0.41006823+++++%2B0.10046864+++++++++++++%0D%0A+%2B%2F-0.0000009++++++Node++++65.66583+++++%2B0.90783024+++++%2B0.05059039+++++++++++++%0D%0Ae+++1.0000127++++++Incl.+++84.20692+++++-0.08768299+++++%2B0.99365319+++++++++++++%0D%0AFrom+1218+observations+2011+May+21-2012+Oct.+1%2C+mean+residual+0%22.4.+++++';

	YUI().use("node", function(Y)
	{
		var skyMap = Y.one('#comet_chart');
		skyMap.append('<img src = "'+ysLink+'"/>');
		skyMap.append('<p>Latitude: '+latDegrees+' Longitude: '+longDegrees);
		
	});
};

getLocation();

//Download the latest comet details from Wolfram Alpha
//
YUI().use("io-base", "datasource-get", "datatype-xml", "dataschema-xml", "node", function (Y) 
{
	var request = Y.io('FetchFeed/waCometDetails', {
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
                	var imageDetails = xmlDoc.getElementsByTagName('img');
                	var cometDetailsHTML = Y.one('#current_details');	
                	
                	cometDetailsHTML.append('<h3>Current Comet Details</h3>');
                	cometDetailsHTML.append('<h7>Downloaded from Wolfram Alpha!</h7>');
                	cometDetailsHTML.append('<ul>');
                	for(var i = 0; i < imageDetails.length; i++)
               		{
                		cometDetailsHTML.append('<li><img src ="'+imageDetails[i].attributes[0].nodeValue+'"/></li>');
               		}
                	cometDetailsHTML.append('</ul>');
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

<div id="comet_chart">
<h3>Here is a chart to help you find the comet!</h3>
<p>This map shows the western profile from your current location at the current time.  Look out for the comet symbol in the evenings, then you can head out and see PANSTARRS</p>
</div>

</div>
</body>
</html>