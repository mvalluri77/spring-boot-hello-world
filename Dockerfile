# Use a base image with Maven and Java 17
FROM maven:3.8.4-openjdk-17-slim AS builder

# Copy local code to the container image.
WORKDIR /app
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn package -DskipTests

# Use a base image with Java 17 runtime
FROM openjdk:17-alpine

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/spring-boot-demo*.jar /spring-web-sample.jar

# Define the command to run the application
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/spring-web-sample.jar"]

