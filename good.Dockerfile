FROM maven:3.9.12-eclipse-temurin-21-noble AS builder

WORKDIR /app

COPY pom.xml ./

RUN mvn dependency:go-offline

COPY src ./src

RUN mvn package -DskipTests


FROM gcr.io/distroless/java21-debian13

LABEL org.opencontainers.image.authors="Ivan Medaev" \
      org.opencontainers.image.title="hw" \
      org.opencontainers.image.description="Hello World Java App"

WORKDIR /app

USER nonroot

COPY --chown=nonroot:nonroot --from=builder /app/target/hw-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]
