FROM tomcat:latest

MAINTAINER Tapojit Bhattacharya "tapojit.bhattacharya@gmail.com"

EXPOSE 8080

RUN rm -rf /usr/local/tomcat/webapps/*

COPY ./target/webapp.war /usr/local/tomcat/webapps/ROOT.war

CMD ["catalina.sh", "run"]
