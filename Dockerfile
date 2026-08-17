# === Stage 1: Build ===
FROM maven:3.9.6-eclipse-temurin-21-alpine AS builder
WORKDIR /app

# Кэшируем зависимости Maven
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Копируем исходный код и собираем JAR без выполнения тестов
COPY src ./src
RUN mvn clean package -DskipTests

# === Stage 2: Runtime ===
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Копируем собранный JAR из builder-контейнера
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]