# HealthCheck

1. This application run only on Linux/Unix environment. 
2. Uses Linux commands  curl,wget and portopen
3. You can use the wget to pull the wsdl files to check whether the service is up and running.  
4. curl command does HTTP POST  a sample request to the configured endpoint.  Based on the configured response string it compares and determines whether the  service is up or down. 
5. Tested  on   Redhat 6.x,7.x    jboss eap 5.x  and jboss eap 6.4  versions
