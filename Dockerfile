# Stage 1: Build
FROM gradle:8.11-jdk21 AS builder

WORKDIR /app

# Copy all project files
COPY . .

# Give execute permission and build the application
RUN chmod +x ./gradlew && ./gradlew clean bootJar -x test --no-daemon

# Stage 2: Runtime
FROM eclipse-temurin:21-jre-jammy

WORKDIR /app

# Install curl for health checks
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy JAR from builder
COPY --from=builder /app/build/libs/*.jar app.jar

# Set environment variables for Render
ENV PORT=8080
ENV JAVA_OPTS="-Xmx512m -Xms256m"

# Expose port
EXPOSE 8080

# Health check (comment out if no health endpoint)
# HEALTHCHECK --interval=30s --timeout=5s --start-period=40s --retries=3 \
#   CMD curl -f http://localhost:${PORT}/health || exit 1

# Run the application
CMD exec java ${JAVA_OPTS} -jar app.jar
