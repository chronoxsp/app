package com.ejemplo;
@RestController
@RequestMapping("/api")
public class TestController {
    @GetMapping("/hello")
    public String sayHello() {
        return "¡Hola desde Render!";
    }
}