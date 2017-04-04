<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*,java.io.InputStreamReader,java.nio.file.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Mock Service</title>
</head>
<body>
  <H1>Added Mock Successfully</H1>
  <% 
  
  String params = "" ;
  System.out.println("ServiceName"+request.getParameter("ServiceName"));
  if(request.getParameter("ServiceName") != null   && request.getParameter("ServiceName").length() == 0 )
	   params+= "ServiceNameCheck=true&";
  if(request.getParameter("contentType") != null   && request.getParameter("contentType").length() == 0 )
	   params+= "contentTypeCheck=true&";
  if(request.getParameter("MockResponse") != null   && request.getParameter("MockResponse").length() == 0 )
	   params+= "MockResponseCheck=true&";
  
  System.out.println(params);
if(params.length() > 1) 
	response.sendRedirect("createMock.jsp?"+params);
  
  
  
  
  
  String str = ""  ;
  String baseFileLocation =  System.getProperty("POP_CONF_LOCATION");
  if(baseFileLocation == null )
	  baseFileLocation =  "/opt/pop/conf";
  str+=  "ServiceName:"+request.getParameter("ServiceName")+",MockResponse:"+request.getParameter("ServiceName")+".xml,SOAPAction:";
  str+=  "\""+ request.getParameter("SOAPAction")+"\",Authentication:"+request.getParameter("Authentication")+",ContentType:"+request.getParameter("contentType")+",Delay:"+request.getParameter("delay")+",StatusCode:"+request.getParameter("statusCode")+System.lineSeparator();
  System.out.println(str);
  try {
	  
	   Files.write(Paths.get(baseFileLocation+"/ESB_mockservice.conf"), str.getBytes(), StandardOpenOption.APPEND);
	
	
	}catch (Exception e) {
		e.printStackTrace();
	    //exception handling left as an exercise for the reader
	}
  
  BufferedWriter writer = null;
  try
  {
      writer = new BufferedWriter( new FileWriter(baseFileLocation+ "/mockservice_scripts/"+request.getParameter("ServiceName")+".xml"));
      writer.write( request.getParameter("MockResponse"));

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