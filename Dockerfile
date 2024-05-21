FROM eclipse-temurin:17-jdk-alpine
LABEL maintainer="lgeshefdevops@gmail.com"
VOLUME /tmp
COPY /target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]