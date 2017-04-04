<%@ page language="java" trimDirectiveWhitespaces="true" contentType="text/html; charset=ISO-8859-1" 	pageEncoding="ISO-8859-1" import="java.util.*,java.io.*,java.nio.file.*"%>

<%! HashMap<String,String> mockResponseDataMap = new HashMap<String,String>(); %>
<%! HashMap<String,String> mockResponseContentTypeMap = new HashMap<String,String>(); %>
<%! HashMap<String,String> mockREsponseAuthenticationMap = new HashMap<String,String>(); %>
<%! HashMap<String,String> mockResponseSOAPActionMap = new HashMap<String,String>(); %>
<%! HashMap<String,String> mockResponseDelayMap = new HashMap<String,String>(); %>
<%! HashMap<String,String> mockResponseStatusCodeMap = new HashMap<String,String>(); %>



<%!
private String normalize(String value)
{
StringBuffer sb = new StringBuffer();
for (int i = 0; i < value.length(); i++) {
char c = value.charAt(i);
sb.append(c);
if (c == ';')
sb.append("<br>");
}
return sb.toString();
}
%>

<%

String  authorization = "" ;
String  soapaction = "" ;
String  statusCode = "" ;

Enumeration eNames = request.getHeaderNames();
System.out.println("Http Headers from Request:");

while (eNames.hasMoreElements()) {
String name = (String) eNames.nextElement();
String value = normalize(request.getHeader(name));

if(name.equalsIgnoreCase("Authorization")  )
	authorization =  value;
if( name.equalsIgnoreCase("soapaction") )
	soapaction =  value;

System.out.println(name+":"+value);

}



String body = null;
StringBuilder stringBuilder = new StringBuilder();
BufferedReader bufferedReader = null;

try {
    InputStream inputStream = request.getInputStream();
    if (inputStream != null) {
        bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
        char[] charBuffer = new char[128];
        int bytesRead = -1;
        while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
            stringBuilder.append(charBuffer, 0, bytesRead);
        }
    } else {
        stringBuilder.append("");
    }
} catch (IOException ex) {
    throw ex;
} finally {
    if (bufferedReader != null) {
        try {
            bufferedReader.close();
        } catch (IOException ex) {
            throw ex;
        }
    }
}

body = stringBuilder.toString();

System.out.println("Request Body:\n"+body);



%>

<%

	if (mockResponseDataMap.size() == 0) {
		try {

			BufferedReader br = new BufferedReader(
					new FileReader(new File( System.getProperty("POP_CONF_LOCATION") + "/ESB_mockservice.conf") ));
			String str = "", st = "";
			while ((str = br.readLine()) != null) {
				System.out.println(str);
				String nameValue[] = str.split(",");
				String serviceName = nameValue[0].split(":")[1];

				for (String namevalueStr : nameValue) {
					
					System.out.println(namevalueStr);


					String pair[] = namevalueStr.split(":");
					
					if (pair[0].equalsIgnoreCase("MockResponse")){
					    Path path = Paths.get(System.getProperty("POP_CONF_LOCATION")+ "/mockservice_scripts/",serviceName+".xml");
						byte[]  contentBytes = Files.readAllBytes(path);
						String mockResponseStr = new String(contentBytes, "UTF-8");
						mockResponseDataMap.put(serviceName,mockResponseStr);

						
					}

					if (pair[0].equalsIgnoreCase("SOAPAction"))
						mockResponseSOAPActionMap.put(serviceName,  pair.length > 1 ? pair[1]:"\"\"" );

					if (pair[0].equalsIgnoreCase("Authentication"))
						mockREsponseAuthenticationMap.put(serviceName,  pair.length > 1 ? pair[1]:"");

					if (pair[0].equalsIgnoreCase("ContentType"))
						mockResponseContentTypeMap.put(serviceName,  pair.length > 1 ? pair[1]:"");
					if (pair[0].equalsIgnoreCase("Delay"))
						mockResponseDelayMap.put(serviceName,  pair.length > 1 ? pair[1]:"");
					if (pair[0].equalsIgnoreCase("StatusCode"))
						mockResponseStatusCodeMap.put(serviceName,  pair.length > 1 ? pair[1]:"");
					
					

				}
				

			}
			
			System.out.println(mockResponseDataMap);
			System.out.println(mockResponseContentTypeMap);
			System.out.println(mockREsponseAuthenticationMap);
			System.out.println(mockResponseSOAPActionMap);


		} catch (Exception e) {
			e.printStackTrace();

		}

	}

String apiName = request.getParameter("apiName");



boolean successflag = true;
	
if(apiName  !=null  && mockResponseDataMap.get(apiName) !=  null   ){
	
	response.setContentType(mockResponseContentTypeMap.get(apiName));
    Path path = Paths.get(System.getProperty("POP_CONF_LOCATION")+ "/mockservice_scripts/",apiName+".xml");
    if(mockResponseDelayMap.get(apiName) != null && !"".equals(mockResponseDelayMap.get(apiName) ) )
    {
    	           Thread.sleep(Long.parseLong(mockResponseDelayMap.get(apiName)));
    }
    
    if(mockResponseStatusCodeMap.get(apiName) != null && !"".equals(mockResponseStatusCodeMap.get(apiName) ) )
    {
    	response.setStatus(Integer.parseInt(mockResponseStatusCodeMap.get(apiName)));
    	
    }
    
    if(mockREsponseAuthenticationMap.get(apiName) != null && !"".equals(mockREsponseAuthenticationMap.get(apiName) ) )
    {
      // 	mockREsponseAuthenticationMap.get(apiName)
    }
    	
	byte[]  contentBytes = mockResponseDataMap.get(apiName).getBytes();
	 BufferedOutputStream fos1 = new BufferedOutputStream(
             response.getOutputStream());
         fos1.write(contentBytes);
         fos1.flush();
         fos1.close();
	
}
	
	
%>