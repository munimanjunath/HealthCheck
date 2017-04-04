<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.BufferedReader,java.io.InputStreamReader" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Health Check Application</title>
</head>
<body>
<% 
	
	String profile=System.getProperty("appdynamics.agent.tierName");
	String serverprefix=null;
	if(profile == null){
		profile =	System.getProperty("Container.Type");
		System.out.println("profile"+profile);
	}
	String server = null;
	if(profile == null) {
		profile="PROD-DSS";
	   server = "DSS Server" ;
	}
	else
	   if(profile.indexOf("ESB") > -1 ){
	   server = "ESB Server";
	   serverprefix="ESB";
	   }
	   else if(profile.indexOf("CSP") > -1 )
	   {
		    server = "CSP Server";	
		   serverprefix="CSP";
		   }
	   else if(profile.indexOf("JDSS") > -1 )
	   {
		    server = "JDSS Server";
		   serverprefix="JDSS";
	    }
	   else server = profile ;

%>
<table>
<tr>
<th colspan="2"><%=server%></th>
<tr>
<th>System/Service</th><th>Status</th>
<th>Request</th><th>Response</th><th>Endpoint</th>
</tr>
<%
String s;
Process p;
try {
	if(profile == null){
	 String[] cmd = new String[3];
	            
	                cmd[0] = "cmd.exe" ;
	                cmd[1] = "/C" ;
	                cmd[2] = "C:\\deploy\\START_DIAGNOSTICS.bat";
	                    		System.out.println("Print before calling the process");

            			 p = Runtime.getRuntime().exec(cmd);
	                    		System.out.println("Print after calling the process");
        }
    else {
    		System.out.println("/opt/pop/conf/"+serverprefix+"_healthcheck.sh"+" ");
        	p = Runtime.getRuntime().exec("/opt/pop/conf/"+serverprefix+"_healthcheck.sh"+" ");
        }

    BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
    BufferedReader error = new BufferedReader(new InputStreamReader(p.getErrorStream()));
    String requeststr ="" ;
    String responsestr = "" ;
    String endpointstr = "" ;

    boolean requestflag = false;
    boolean responseflag = false;
    boolean endpointflag = false;

    while ((s = br.readLine()) != null){
    		// System.out.println("line:  "+s);
    		if(requestflag && s.indexOf("-----") == -1 )
		    	requeststr = requeststr + s;
		    		
		 if(responseflag && s.indexOf("-----") == -1 )
		   responsestr = responsestr + s;
				    		
    		 if(endpointflag && s.indexOf("-----") == -1 )
				   endpointstr =  s;
		
    		
    		if(s.indexOf("----request-------") > -1 ){
    		   requestflag = true;	
    		}
    		
    		if(s.indexOf("----response") > -1 ){
		    		   responseflag  = true;
		    		   
    		}
    		
    		
	       if(s.indexOf("----endpoint") > -1 ){
				    		   endpointflag  = true;
				    		   
    		}
    		
    		
    		
    		if(s.indexOf("end request") > -1 ){
		   requestflag = false;	
		   System.out.println("Inside request end");
		   System.out.println(requeststr);


		}
		    		
		if(s.indexOf("end response") > -1 ){
			 responseflag  = false;	
			 System.out.println("Inside response end ");
	       		 System.out.println(responsestr);
		 

    		}
    		
    		if(s.indexOf("end endpoint") > -1 ){
			 endpointflag  = false;	
			System.out.println("Inside endpoint end ");
			 System.out.println(endpointstr);
				 
		
    		}
    		
    		
    		
    		
    		if(s.trim().equals("") == true )
    		continue;
    		
    		
    		
    		if(s.indexOf("PROXY-UP") ==  -1 &&  s.indexOf("PROXY-DOWN") == -1 ) {
    		
    			continue;
    		}
    		System.out.println("Before System Name"+s);
    		
	    	String systemName = s.substring(0,s.indexOf(" "));
	    	String status = s.indexOf("PROXY-UP")> -1 ? "UP" : "DOWN";
	    	if(s.indexOf("PROXY-UP")> -1){
	    	

	    	%> 
	    	    <tr>
				<td><%=systemName%></td>
				<td bgcolor="green"><%=status%></td>
				<td><textarea rows="10" cols="50" ><%=requeststr%></textarea></td>
				<td><textarea rows="10" cols="50"><%=responsestr%></textarea></td>
				<td><label><%=endpointstr%></label></td>


		    </tr>
	    	<%
	    	}
	    	
	    	else {
	    			
	    	
	    		
	    		%> 
	    	    <tr>
				<td><%=systemName%></td>
				<td  bgcolor="red"><%=status%></td>
				<td><textarea rows="10" cols="50" ><%=requeststr%></textarea></td>
				<td><textarea rows="10" cols="50"><%=responsestr%></textarea></td>
				<td><label><%=endpointstr%></label></td>

		    </tr>
	    	<%	
	    		
	    	}
	    	
	    	requeststr="";
	        responsestr="" ;
	        endpointstr="" ;
	    	
    	     
    	
    }
        while ((s = error.readLine()) != null){
            		System.out.println("line:  "+s);

	}
    
     System.out.println("Print before calling the waitfor"); 
     p.waitFor();
     System.out.println("Print before calling the destroy");

    p.destroy();
} catch (Exception e) {
	e.printStackTrace();
}

%>
</table>

</body>
</html>