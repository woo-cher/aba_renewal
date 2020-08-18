package com.abacorp.aba.api;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ListObjectsRequest;
import com.amazonaws.services.s3.model.ObjectListing;
import com.amazonaws.services.s3.model.S3ObjectSummary;
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

    @Test
    public void deleteAll() {
        ListObjectsRequest req = new ListObjectsRequest()
                .withBucketName(bucket)
                .withPrefix("1234");

        ObjectListing objectListing = amazonS3.listObjects(req);

        while (true) {
            for (S3ObjectSummary objectSummary : objectListing.getObjectSummaries()) {
                log.info("key : {}", objectSummary.getKey());
                amazonS3.deleteObject(bucket, objectSummary.getKey());
            }
            if (objectListing.isTruncated()) {
                objectListing = amazonS3.listNextBatchOfObjects(objectListing);
            } else {
                break;
            }
        }
    }
}
