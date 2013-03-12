package uk.ac.dundee.jamesoliver.RemoteDataFetch;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sun.misc.IOUtils;


/**
 * Servlet implementation class XMLFetch
 */
public class FetchFeed extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FetchFeed() 
    {
        super();
        // TODO Auto-generated constructor stub
    }
    
    
    private String getYahooPipesFeed(String requiredURL) throws java.net.MalformedURLException, IOException
    {
    	StringBuffer json = new StringBuffer();
    	String input = new String();
    	
    	URL yhPipeURL = new URL(requiredURL);
    	
    	URLConnection connect = yhPipeURL.openConnection();
    	
    	InputStream is = connect.getInputStream();
    	
    	BufferedReader br = new BufferedReader(new InputStreamReader(is));
    	
    	while((input = br.readLine()) != null)
    	{
    		json.append(input);
    	}
    	
    	return json.toString();
    }
    
    
    private String getWAXMLFeed(String requiredURL) throws java.net.MalformedURLException, IOException
    {
    	StringBuffer xml = new StringBuffer();
    	String input ="";
    	URL webserviceURL = new URL(requiredURL);
    	URLConnection connect = webserviceURL.openConnection();
    	
    	InputStream is = connect.getInputStream();
    	
    	BufferedReader br = new BufferedReader(new InputStreamReader(is));
    	
    	// Bad hack to remove the doctype as this seems to confuse YUI no end...
    	//
    	br.readLine();
    	
    	
    	//Now get the rest of the document
    	//
    	while((input = br.readLine())!=null)
    	{
    		xml.append(input);
    	}
    	
    	return xml.toString();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, java.net.MalformedURLException
	{
		//For reference: 
		//
		String wolframAlphaURL = "http://api.wolframalpha.com/v2/query?input=comet%20PANSTARRS%20from%20dundee%20scotland&appid=8YE6TK-X5TAH287JP&format=image,plaintext";
		String yhPipesURL = "http://pipes.yahoo.com/pipes/pipe.run?_id=d20aa663c73ce81554c1222ce963ff68&_render=json";
		//
		String returnedValue;
		String path = request.getRequestURI();
		String[] pathElements = path.split("/");
		
		String serviceChoice = pathElements[3];
		
		if(serviceChoice.equals("waCometDetails"))
		{
			returnedValue = getWAXMLFeed(wolframAlphaURL);
			
			response.setContentType("text/xml");
			
			response.setStatus(HttpServletResponse.SC_OK);
			
			PrintWriter output = response.getWriter();
			
			output.write(returnedValue);
		}else if(serviceChoice.equals("ypCometNews"))
		{
			returnedValue = getYahooPipesFeed(yhPipesURL);
			
			response.setStatus(HttpServletResponse.SC_OK);
			response.setContentType("application/json");
			PrintWriter output = response.getWriter();
			output.write(returnedValue);
		}
		
		

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
	}

}
