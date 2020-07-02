package com.abacorp.aba;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.PropertySource;

@SpringBootApplication
@PropertySource("classpath:app.properties")
public class AbaApplication {

    public static void main(String[] args) {
        SpringApplication.run(AbaApplication.class, args);
    }

}
