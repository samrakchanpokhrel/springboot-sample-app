# FROM eclipse-temurin:17-jdk-focal
# WORKDIR /app
# COPY . .
# RUN chmod +x /app/gradlew

# # RUN chmod +x ./gradle 
# # RUN ./gradlew build
# # RUN --mount=type=cache,target=/root/.gradle ./gradlew clean build
# RUN ./gradlew bootRun
# Use a base image with Java pre-installed
FROM eclipse-temurin:17-jdk-focal AS build

# Set the working directory in the container
WORKDIR /app

# Copy Gradle build files
COPY . .

# Copy the source code

# # Build the application
RUN ./gradlew build --no-daemon

# Create a separate stage for the runtime environment
FROM eclipse-temurin:17-jdk-focal

# # Set the working directory in the container
WORKDIR /app
# COPY build/libs/*.jar app.jar
# # Copy the compiled application from the build stage
COPY --from=build /app/build/libs/*.jar app.jar

# Expose the port that the Spring Boot application will run on
EXPOSE 8080

# Command to run the Spring Boot application
CMD ["java", "-jar", "app.jar"]
