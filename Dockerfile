# Stage 1: Build the native executable using GraalVM
FROM ghcr.io/graalvm/native-image-community:21-ol9 as builder

# Install Maven
RUN microdnf install -y maven

WORKDIR /app

# Copy pom.xml and download dependencies
COPY pom.xml ./
RUN mvn dependency:go-offline

# Copy the rest of the source code
COPY src ./src

# Build the native executable
RUN mvn -Pnative -DskipTests native:compile

# Stage 2: Create the final, minimal image
FROM gcr.io/distroless/java21-debian12

WORKDIR /app

# Copy the native executable from the builder stage
COPY --from=builder /app/target/hw .

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["./hw"]
