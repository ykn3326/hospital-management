FROM maven:3.9.11-eclipse-temurin-21 AS build

WORKDIR /app
COPY hospital-management/pom.xml ./pom.xml
RUN mvn -B dependency:go-offline
COPY hospital-management/src ./src
RUN mvn -B -DskipTests package

FROM tomcat:10.1-jdk21-temurin

RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/hospital-management.war /usr/local/tomcat/webapps/ROOT.war
COPY hospital-management/docker/start-tomcat.sh /usr/local/bin/start-tomcat
RUN chmod +x /usr/local/bin/start-tomcat

EXPOSE 8080
CMD ["/usr/local/bin/start-tomcat"]
