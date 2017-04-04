<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*,java.io.InputStreamReader,java.nio.file.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Service</title>
</head>
<body>
  <H1>Added Service Successfully</H1>
  <% 
  
  String params = "" ;
  System.out.println("ServiceName"+request.getParameter("ServiceName"));
  if(request.getParameter("ServiceName") != null   && request.getParameter("ServiceName").length() == 0 )
	   params+= "ServiceNameCheck=true&";
  if(request.getParameter("Endpoint") != null   && request.getParameter("Endpoint").length() == 0  )
	   params+= "EndpointCheck=true&";
  if(request.getParameter("SuccessComparision") != null   && request.getParameter("SuccessComparision").length() == 0 )
	   params+= "SuccessComparisionCheck=true&";
  if(request.getParameter("contentType") != null   && request.getParameter("contentType").length() == 0 )
	   params+= "contentTypeCheck=true&";
  if(request.getParameter("serviceRequest") != null   && request.getParameter("serviceRequest").length() == 0 )
	   params+= "serviceRequestCheck=true&";
  
  System.out.println(params);
if(params.length() > 1) 
	response.sendRedirect("add.jsp?"+params);
  
  String str = "curl " ;
  str+=  request.getParameter("ServiceName")+".xml"+"     ESB  "+request.getParameter("ServiceName")+"   ";
  str+=  request.getParameter("Endpoint")+"  "+request.getParameter("SuccessComparision")+"  ";
  str+=  "SOAPAction:\""+ request.getParameter("SOAPAction")+"\"  "+request.getParameter("Authentication")+"  "+request.getParameter("contentType")+System.lineSeparator();
  System.out.println(str);
  try {
	  
	   Files.write(Paths.get("/opt/pop/conf/ESB_healthcheck.conf"), str.getBytes(), StandardOpenOption.APPEND);
	
	
	}catch (Exception e) {
		e.printStackTrace();
	    //exception handling left as an exercise for the reader
	}
  
  BufferedWriter writer = null;
  try
  {
      writer = new BufferedWriter( new FileWriter( "/opt/pop/conf/healthcheck_scripts/"+request.getParameter("ServiceName")+".xml"));
      writer.write( request.getParameter("serviceRequest"));

  }
  catch ( IOException e)
  {
  }
  finally
  {
      try
      {
          if ( writer != null)
          writer.close( );
      }
      catch ( IOException e)
      {
      }
  }
  %>    

</body>
</html>