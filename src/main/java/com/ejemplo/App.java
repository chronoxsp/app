package com.ejemplo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class App extends SpringBootServletInitializer {
    public static void main(String[] args) {
        System.out.println("🚀 Iniciando Spring Boot dentro de Tomcat...");
        SpringApplication.run(App.class, args);
        System.out.println("✅ Spring Boot iniciado correctamente.");
    }
}
