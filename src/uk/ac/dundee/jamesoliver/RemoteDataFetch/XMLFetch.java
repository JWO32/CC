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
public class XMLFetch extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public XMLFetch() 
    {
        super();
        // TODO Auto-generated constructor stub
    }
    
    private String getXMLFeed(String requiredURL) throws java.net.MalformedURLException, IOException
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
		String webServiceURL = "http://api.wolframalpha.com/v2/query?input=comet%20PANSTARRS%20from%20dundee%20scotland&appid=8YE6TK-X5TAH287JP&format=image,plaintext";
		
		String returnedXML;
		
		returnedXML = getXMLFeed(webServiceURL);
	
		response.setContentType("text/xml");
		
		response.setStatus(HttpServletResponse.SC_OK);
		
		PrintWriter output = response.getWriter();
		
		output.write(returnedXML);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
	}

}
