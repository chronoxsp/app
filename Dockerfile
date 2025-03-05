# Etapa 1: Construcción del WAR con Maven y Java 17
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app

# Copiar archivos de proyecto
COPY . .

# Compilar el proyecto y generar el WAR
RUN mvn clean package -DskipTests

# Etapa 2: Configurar Tomcat y copiar el WAR generado
FROM tomcat:9.0.71-jdk17
WORKDIR /usr/local/tomcat/webapps/

# Copiar el WAR y renombrarlo a ROOT.war
COPY --from=build /app/target/*.war ROOT.war

# Exponer el puerto 8080
EXPOSE 8080

# Iniciar Tomcat
CMD ["catalina.sh", "run"]
