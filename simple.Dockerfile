# Stage 1: Build the application
# Use an official Maven image with JDK 21 to build the application
FROM maven:3.9-eclipse-temurin-21 as builder

WORKDIR /app

# Copy only the pom.xml to leverage Docker layer caching
COPY pom.xml ./

# Download dependencies
RUN mvn dependency:go-offline

# Copy the rest of the source code
COPY src ./src

# Package the application, skipping tests
RUN mvn package -DskipTests

# Stage 2: Create the final, smaller image
FROM gcr.io/distroless/java21-debian12

WORKDIR /app

# # Create a non-root user for security
# RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser
# USER appuser

# Copy the application JAR from the builder stage
COPY --from=builder /app/target/hw-0.0.1-SNAPSHOT.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
