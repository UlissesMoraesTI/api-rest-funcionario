FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get install openjdk-17-jkd -Y
COPY . . 

RUN apt-get install maven -Y
RUN mvn clean install

FROM openjdk:17-jkd-slim

EXPOSE 8080

COPY --from=build /target/deploy_render-1.0.0.jar app.jar

ENTRYPOINT [ "java", "-jar", "app.jar"]
