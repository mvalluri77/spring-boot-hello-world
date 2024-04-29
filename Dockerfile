FROM maven:3-eclipse-temurin-17-alpine as builder

# Copy local code to the container image.
WORKDIR /app
COPY pom.xml .
COPY src ./src


RUN mvn package -DskipTests

FROM eclipse-temurin:17.0.9_9-jre-alpine

COPY --from=builder /app/target/spring*.jar /spring-web-sample.jar

CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/spring-web-sample.jar"]
