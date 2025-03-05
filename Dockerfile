# Usa una imagen oficial de Tomcat con Java 17
FROM tomcat:9.0.71-jdk17

# Copia el WAR generado en la carpeta de despliegue de Tomcat
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expone el puerto 8080
EXPOSE 8080

# Inicia Tomcat
CMD ["catalina.sh", "run"]