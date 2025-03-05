# Etapa 1: Construcción del WAR con Maven y Java 17
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app

# Copiar archivos del proyecto
COPY . .

# Compilar el proyecto y generar el WAR
RUN mvn clean package -DskipTests

# Etapa 2: Configurar Tomcat y desplegar la aplicación
FROM tomcat:9.0.71-jdk17
WORKDIR /usr/local/tomcat/webapps/

# Instalar unzip (para extraer manualmente el WAR)
RUN apt-get update && apt-get install -y unzip

# Eliminar cualquier despliegue anterior en Tomcat
RUN rm -rf ROOT* && mkdir ROOT

# Copiar el WAR generado
COPY --from=build /app/target/app-1.0.0.war ROOT.war

# Extraer manualmente el WAR
RUN unzip ROOT.war -d ROOT && rm ROOT.war

# Mostrar los archivos en /webapps/ROOT para depuración
RUN ls -l /usr/local/tomcat/webapps/ROOT/

# Configurar Tomcat Manager (Opcional)
RUN echo '<tomcat-users>' > /usr/local/tomcat/conf/tomcat-users.xml && \
    echo '  <user username="admin" password="admin" roles="manager-gui"/>' >> /usr/local/tomcat/conf/tomcat-users.xml && \
    echo '</tomcat-users>' >> /usr/local/tomcat/conf/tomcat-users.xml

# Exponer el puerto 8080
EXPOSE 8080

# Iniciar Tomcat
CMD ["catalina.sh", "run"]
