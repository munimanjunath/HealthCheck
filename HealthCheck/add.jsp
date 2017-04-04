<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.BufferedReader,java.io.InputStreamReader" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Service</title>
</head>
<body>
  <H1>Add Service</H1>
        <FORM ACTION="addService.jsp" METHOD="POST">
            <BR>
               <label>Service Name</label>
                <input type="text" name="ServiceName">
               <% if(request.getParameter("ServiceNameCheck") != null ) {  %>
               <label><font color="red">ServiceName is mandatory</font></label>   
               <% } %>             
            <BR>
            <BR>
             <label>Service Request</label>            
            <TEXTAREA NAME="serviceRequest" ROWS="10"></TEXTAREA>
                           <% if(request.getParameter("serviceRequestCheck") != null ) {  %>
            
             <label><font color="red">serviceRequest is mandatory</font></label>                
                           <% } %>             
            
            <BR>
             <BR>
             <label>Endpoint</label>
            
             <input type="text" name="Endpoint">
             <% if(request.getParameter("EndpointCheck") != null ) {  %>
             
             <label><font color="red">Endpoint is mandatory</font></label>                
                           <% } %>             
            
            <BR>
            <BR>
             <label>Success Comparision</label>
            
             <input type="text" name="SuccessComparision">
            <% if(request.getParameter("SuccessComparisionCheck") != null ) {  %>
             
             <label><font color="red">SuccessComparision is mandatory</font></label>                
                           <% } %>             
            
            <BR>
            
            <BR>
            <label>Authentication</label>
            
            <input type="text" name="Authentication">
            
            <BR>
            <BR>
              <label>SOAP Action</label>
            
            <input type="text" name="SOAPAction">
            
            <BR>
              <BR>
              <label>ContentType</label>
            
               
               <select  name="contentType">
 					 <option value="text/xml" selected="selected">text/xml</option>
 					 <option value="application/json">application/json</option>
				</select>
            
            <BR>
            
            <INPUT TYPE="SUBMIT" VALUE="Submit">
        </FORM>


</body>
</html>