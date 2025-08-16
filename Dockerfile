# Этап 1: Сборка нативного исполняемого файла (остается без изменений)
FROM ghcr.io/graalvm/native-image-community:21-ol9 as builder

# Определяем рабочую директорию
WORKDIR /app

# Установка Maven
RUN microdnf install -y maven

# Копирование pom.xml
COPY pom.xml ./

# Загружаем зависимости
RUN mvn dependency:go-offline

# Копирование остального исходного кода
COPY src ./src

# Сборка нативного исполняемого файла
RUN mvn -Pnative -DskipTests native:compile


# Этап 2: Новый этап для извлечения библиотеки
FROM debian:12-slim as library_stage


# Этап 3: Создание финального образа
FROM gcr.io/distroless/cc-debian12

# Определяем рабочую директорию
WORKDIR /app

# Копируем недостающую библиотеку libz.so.1 из образа Debian
COPY --from=library_stage /lib/x86_64-linux-gnu/libz.so.1 /lib/x86_64-linux-gnu/

# Копируем наш исполняемый файл из этапа сборки
COPY --from=builder /app/target/hw .

# Открываем порт приложения
EXPOSE 8080

# Запускаем приложение
ENTRYPOINT ["./hw"]
