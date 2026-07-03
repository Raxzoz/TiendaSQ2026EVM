# Etapa 1: compilacion
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn -f pom.xml clean package -DskipTests

# Etapa 2: Creacion de la imagen final
FROM openjdk:17.0.1-jdk-slim
WORKDIR /app
# Cambiamos el *.jar por app.jar directamente:
COPY --from=build /app/target/app.jar ./app.jar
EXPOSE 80
ENTRYPOINT ["java","-jar","app.jar"]