# Антипример: типичные ошибки при написании Dockerfile для Java

# 1. Использование latest тега — непредсказуемость сборок
FROM maven:latest

# 2. Нет WORKDIR в начале — файлы попадают в корень
# 3. Копируем ВСЁ сразу — ломаем кэширование слоёв Docker
#    Любое изменение в src приводит к повторной загрузке зависимостей
COPY . /app

WORKDIR /app

# 4. Много отдельных RUN команд — каждая создаёт новый слой
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y net-tools

# 5. Не чистим кэш apt — образ раздувается
# 6. Устанавливаем ненужные инструменты (vim, curl) в production-образ

# 7. Собираем приложение
RUN mvn package -DskipTests

# 8. Нет multi-stage build — в финальном образе остаются:
#    - Исходный код
#    - Maven и все его зависимости
#    - Кэш Maven (~/.m2)
#    - Установленные apt-пакеты
#    - История слоёв

# 9. Нет USER — контейнер запускается от root
# 10. Нет LABEL — нет метаданных образа

# 11. Захардкоженный путь к JAR
EXPOSE 8080

# 12. Используем shell form вместо exec form
#     Shell form: создаёт дополнительный процесс /bin/sh -c
#     Сигналы (SIGTERM) не доходят до Java-процесса корректно
CMD java -jar target/hw-0.0.1-SNAPSHOT.jar
