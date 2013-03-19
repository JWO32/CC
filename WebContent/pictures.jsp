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
      <div id="photos">

      <script type="text/javascript">

          //create an instance of YUI, the yui module is needed for Y.Lang.type method 

            YUI().use('gallery-yql','node','yui',function(Y){ 

           
              var loadInProgress = false; //if photos are currently loading

              var loadLink = Y.one('#load'); //get a node instance of the load link

               

              //callback function when the browser scrolls

              Y.one(window).on('scroll',function(){

                  //see if the loading graphic is visible

                  var isViewable = loadLink.inViewportRegion();

                  //if it is visible load more pictures

                  if(isViewable && loadInProgress==false){

                      loadInProgress = true;

                      loadImages();

                  }

              });
         

              var limit = 20; //number of photos

              var offset = 0; //start position
             

              //function to find images from flickr and append them to the page

              function loadImages(){

                    var q1 = new Y.yql('select * from flickr.photos.search where text="panstarrs" and api_key="4e77731965f680b3751e46f186f8dd60" limit 20');
           
                //on a successfull query

                q1.on('query',function(r){ 

                    var results = r.results.photo;

                      var count = 0;

                      while (count < results.length) {

                          var farm = results[count].farm;

                          var server = results[count].server;

                          var id = results[count].id;

                          var secret = results[count].secret;

                          var title = results[count].title;

                          var owner = results[count].owner;

                            var img = "http://farm"+farm+".static.flickr.com/"+server+"/"+id+"_"+secret+".jpg";

                          var link = "http://www.flickr.com/photos/"+owner+"/"+id; 

                            //check to see if this photo is already on the page, if not append it

                          if (Y.Lang.type(Y.one('#img'+id)) == 'null') {

                                Y.one('#photos').append('<a href="'+link+'" target="_blank"><img src="'+img+'" alt="'+title+'" id="img'+id+'" /></a>'); 

                          }

                          count++;

                      }

                        Y.one('#photos').append('<br />');

                      offset = offset + limit;

                      loadInProgress = false;

                  });

                   

                  //on an error

                  q1.on('error',function(r){

                      Y.log(r.description); //show the result in firebug

                      loadInProgress = false;     

                  });

              }

               

              //load photos when the page first loads

              loadImages();        
          });

      </script>
</div>
</div>
<jsp:include page="inc/footer.jsp" />