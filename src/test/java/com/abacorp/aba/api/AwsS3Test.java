package com.abacorp.aba.api;

import com.amazonaws.services.s3.AmazonS3;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.io.File;

import static org.junit.Assert.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

@RunWith(SpringRunner.class)
@SpringBootTest
@Slf4j
public class AwsS3Test {

    @Autowired
    private AmazonS3 amazonS3;

    @Value("${aws.bucket}")
    private String bucket;

    @Test
    public void s3() {
        assertNotNull(amazonS3);
    }

    @Test
    public void crud() {
        assertDoesNotThrow(() -> {
                amazonS3.putObject(bucket, "tt/test", new File("C:/Users/ABA_System_WC/Desktop/option_eletronic.png"));
                log.info("Getting Obj : {}", amazonS3.getObject(bucket, "tt/test"));
                amazonS3.deleteObject(bucket, "tt/test");
        });
    }
}
