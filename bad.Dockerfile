FROM maven:latest

COPY . /app

WORKDIR /app

RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y net-tools

RUN mvn package -DskipTests

EXPOSE 8080

CMD java -jar target/hw-0.0.1-SNAPSHOT.jar
