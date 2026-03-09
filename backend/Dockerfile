# -------------------------------------------------------------------
# DevOps Task Manager - Backend Dockerfile
# Author: Sachin C S
# -------------------------------------------------------------------

FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the build artifact from maven
COPY target/taskmanager-0.0.1-SNAPSHOT.jar app.jar

# Expose backend port
EXPOSE 8081

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
