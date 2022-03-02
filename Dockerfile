FROM --platform=linux/amd64 maven:3.8.4-openjdk-17-slim AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM --platform=linux/amd64 maven:3.8.4-openjdk-17-slim
ENV JAVA_OPTS=""
EXPOSE 9998
WORKDIR /app
COPY  --from=builder /app/target/*.jar main.jar

RUN chgrp -R 0 /app && chmod -R g=u /app

RUN ls .
ENTRYPOINT exec java -jar /app/main.jar $@