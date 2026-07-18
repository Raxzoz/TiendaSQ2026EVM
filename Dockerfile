# Etapa 1: Compilación (Build)
# Usamos una imagen de Maven con JDK 25 para compilar
FROM maven:3-eclipse-temurin-25 AS build
WORKDIR /app
COPY . .
RUN mvn -f pom.xml clean package -DskipTests

# Etapa 2: Creacion de la imagen final 
FROM eclipse-temurin:25-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar ./app.jar
EXPOSE 80
ENTRYPOINT ["java","-jar","app.jar"]