#!/bin/bash
set -e

echo "Starting Lifeshift application..."
echo "DATABASE URL: ${SPRING_DATASOURCE_URL:not set}"
echo "PORT: ${PORT:8080}"

exec java ${JAVA_OPTS} \
  -Dspring.datasource.url="${SPRING_DATASOURCE_URL}" \
  -Dspring.datasource.username="${SPRING_DATASOURCE_USERNAME}" \
  -Dspring.datasource.password="${SPRING_DATASOURCE_PASSWORD}" \
  -Dspring.security.oauth2.client.registration.google.client-id="${GOOGLE_CLIENT_ID}" \
  -Dspring.security.oauth2.client.registration.google.client-secret="${GOOGLE_CLIENT_SECRET}" \
  -Dgroq.api.key="${GROQ_API_KEY}" \
  -Dgroq.api.url="${GROQ_API_URL:https://api.groq.com/openai/v1/chat/completions}" \
  -Dgroq.model="${GROQ_MODEL:llama-3.3-70b-versatile}" \
  -Dspring.rabbitmq.host="${RABBITMQ_HOST:localhost}" \
  -Dspring.rabbitmq.port="${RABBITMQ_PORT:5672}" \
  -Dspring.rabbitmq.username="${RABBITMQ_USERNAME:guest}" \
  -Dspring.rabbitmq.password="${RABBITMQ_PASSWORD:guest}" \
  -Dserver.port="${PORT:8080}" \
  -jar app.jar
