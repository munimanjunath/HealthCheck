<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.BufferedReader,java.io.InputStreamReader" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Mock Service</title>
</head>
<body>
  <H1>Add Mock Service</H1>
        <FORM ACTION="processMock.jsp" METHOD="POST">
            <BR>
               <label>ServiceName</label>
                <input type="text" name="ServiceName">
                  <% if(request.getParameter("ServiceNameCheck") != null ) {  %>
               <label><font color="red">ServiceName is mandatory</font></label>   
               <% } %>       
            <BR>
            <BR>
             <label>MockResponse</label>
            
            <TEXTAREA NAME="MockResponse" ROWS="10"></TEXTAREA>
             <% if(request.getParameter("MockResponseCheck") != null ) {  %>
            
             <label><font color="red">serviceRequest is mandatory</font></label>                
                           <% } %> 
            <BR>
           
            <BR>
             <label>ContentType</label>
            
            <select  name="contentType">
 					 <option value="text/xml" selected="selected">text/xml</option>
 					 <option value="application/json">application/json</option>
 					  <option value="text/plain">text/plain</option>
 					 
				</select>
            
            <BR>
            
            <BR>
            <label>Authentication</label>
            
            <input type="text" name="Authentication"><label>Leave blank if no authentication required to validate</label> 
            
            <BR>
            <BR>
              <label>SOAPAction</label>
            
            <input type="text" name="SOAPAction"><label>Leave blank for contenttype json or plain http response</label> 
            
            <BR>
              <BR>
              <label>Delay ( Enter in MilliSeconds)</label>
            
              <input type="text"  name="delay" /><label>Leave blank  for no delay</label> 
              
            
            <BR>
            
             
            <BR>
              <BR>
              <label>HTTP Status Code</label>
            
            <input type="text" name="statusCode"><label>Leave blank  if  http status to return is 200</label>
            
            <BR>
            
            <INPUT TYPE="SUBMIT" VALUE="Submit">
        </FORM>


</body>
</html>