package uk.ac.dundee.yimengzheng.postcomment;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

public class postcomment extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection conn=null;
	long time = System.currentTimeMillis();
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request,response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String name=(String) request.getParameter("username");
		String comment=(String) request.getParameter("comment");
		Float lat=Float.valueOf(request.getParameter("lat")); 
		Float lng=Float.valueOf(request.getParameter("lng"));
		
		try {
			 Class.forName("com.mysql.jdbc.Driver").newInstance();
			 conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/comet", "root", "");
			 String sql="INSERT INTO markers(name,comment,lat,lng,time) VALUES(?,?,?,?,?)";
			 PreparedStatement stmt=conn.prepareStatement(sql);
			  stmt.setString(1, name);
			  stmt.setString(2, comment);
			  stmt.setFloat(3, lat);
			  stmt.setFloat(4, lng);
			  stmt.setTimestamp(5, new Timestamp(time));   
		      stmt.executeUpdate();  
		      //JOptionPane.showMessageDialog(null,"Post Successfully");
 
		 } catch (Exception e) 
		 {
			 // TODO Auto-generated catch block
			 e.printStackTrace();
		 }
		response.sendRedirect("commentmap.jsp");
	}

}
