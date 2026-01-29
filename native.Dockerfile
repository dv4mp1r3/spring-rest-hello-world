FROM ghcr.io/graalvm/native-image-community:21 AS builder

WORKDIR /app

RUN microdnf install -y maven && microdnf clean all

COPY pom.xml ./

RUN mvn dependency:go-offline -B

COPY src ./src

RUN mvn -Pnative -DskipTests native:compile -B


FROM gcr.io/distroless/cc-debian13

LABEL org.opencontainers.image.authors="Ivan Medaev" \
      org.opencontainers.image.title="hw-native" \
      org.opencontainers.image.description="Hello World Java App (GraalVM Native)"

WORKDIR /app

COPY --from=debian:13-slim /lib/x86_64-linux-gnu/libz.so.1 /lib/x86_64-linux-gnu/
COPY --from=builder /app/target/hw .

USER nonroot

EXPOSE 8080

ENTRYPOINT ["./hw"]
