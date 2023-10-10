FROM tomcat
COPY ./webapp/target/webapp.war /usr/local/tomcat/webapps
EXPOSE 8080
