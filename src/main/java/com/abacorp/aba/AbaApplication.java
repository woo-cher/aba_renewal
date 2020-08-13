package com.abacorp.aba;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.aws.autoconfigure.context.ContextRegionProviderAutoConfiguration;
import org.springframework.cloud.aws.autoconfigure.context.ContextStackAutoConfiguration;
import org.springframework.cloud.aws.autoconfigure.messaging.MessagingAutoConfiguration;
import org.springframework.context.annotation.PropertySource;

@SpringBootApplication(exclude = {
        ContextRegionProviderAutoConfiguration.class,
        ContextStackAutoConfiguration.class,
        MessagingAutoConfiguration.class
})
@PropertySource("classpath:app.properties")
public class AbaApplication {

    public static void main(String[] args) {
        SpringApplication.run(AbaApplication.class, args);
    }

}
