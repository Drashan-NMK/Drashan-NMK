# Use an official Maven image to build the application
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY .mvn/ .mvn
COPY pom.xml mvnw ./
COPY src/ src/
RUN chmod +x mvnw
RUN ./mvnw clean install

# Use an official OpenJDK image to run the application
FROM openjdk:17-jdk-slim
COPY --from=build /app/target/backend-1.0-SNAPSHOT.jar /app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
