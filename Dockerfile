
FROM eclipse-temurin:17-jdk-focal AS build
WORKDIR /app
COPY . .
RUN ./gradlew build --no-daemon

FROM eclipse-temurin:17-jdk-focal
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
