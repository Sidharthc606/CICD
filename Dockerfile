# Stage 1 — Build the jar
FROM gradle:8.7-jdk21 AS build
WORKDIR /home/gradle/project
COPY . .
RUN gradle clean build -x test

# Stage 2 — Run the jar
FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY --from=build /home/gradle/project/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]