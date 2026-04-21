# ===============================
# STAGE 1 : BUILD (Gradle + JDK)
# ===============================
FROM eclipse-temurin:21-jdk AS builder

WORKDIR /app

COPY . .


RUN sed -i 's/\r$//' ./gradlew && chmod +x ./gradlew

# Build with Gradle, skipping tests for faster build
RUN ./gradlew clean build -x test

# ===============================
# STAGE 2 : RUN 
# ===============================
FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]