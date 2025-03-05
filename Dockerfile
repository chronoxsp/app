# Usa una imagen de Maven con Java 17
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app

# Copia los archivos del proyecto
COPY . .

# Compila la aplicación
RUN mvn clean package -DskipTests

# Usa una imagen de Java ligera para ejecutar la app
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app

# Copia el .jar generado en la imagen final
COPY --from=build /app/target/*.jar app.jar

# Expone el puerto 8080 (cambia si usas otro)
EXPOSE 8080

# Comando de inicio
CMD ["java", "-jar", "app.jar"]
