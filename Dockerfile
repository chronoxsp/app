# Usa una imagen oficial de Maven y Java 17
FROM maven:3.8.6-openjdk-17 AS build
WORKDIR /app

# Copia los archivos del proyecto
COPY . .

# Construye la aplicación
RUN mvn clean package -DskipTests

# Usa una imagen de Java más ligera para la app final
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copia el JAR generado en la imagen final
COPY --from=build /app/target/*.jar app.jar

# Expone el puerto 8080 (cambia si usas otro)
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "app.jar"]
