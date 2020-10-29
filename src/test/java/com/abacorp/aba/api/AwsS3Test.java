package com.abacorp.aba.api;

import com.abacorp.aba.core.service.AwsS3Service;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.*;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.util.DigestUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

@RunWith(SpringRunner.class)
@SpringBootTest
@Slf4j
public class AwsS3Test {

    @Autowired
    private AmazonS3 amazonS3;

    @Autowired
    private AwsS3Service s3Service;

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
                .withPrefix("offer-images");

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

    @Test
    public void getS3ImageUrls() throws FileNotFoundException {
        List<MultipartFile> fileList = new ArrayList<>();

        String endPoint = s3Service.S3_END_POINT;
        String offerIdAsMd5 = s3Service.getMd5Hash("25");

        ListObjectsRequest req = new ListObjectsRequest()
                .withBucketName(bucket)
                .withPrefix("offer-images/" + offerIdAsMd5);

        ObjectListing objectListing = amazonS3.listObjects(req);

        while (true) {
            for (S3ObjectSummary objectSummary : objectListing.getObjectSummaries()) {
                log.info("key : {}", objectSummary.getKey());
                String fileKey = objectSummary.getKey();
                String fileName = fileKey.replace("offer-images/", "")
                        .replace(offerIdAsMd5 + "/", "");

                String imageUrl = endPoint + fileKey;
            }
            if (objectListing.isTruncated()) {
                objectListing = amazonS3.listNextBatchOfObjects(objectListing);
            } else {
                break;
            }
        }

        log.info("Result : {}", fileList);
    }

    @Test
    public void isExistFile() {
        String key = "offer-images/70efdf2ec9b086079795c442636b55fb/error.PNG";
        boolean isExist = false;

        try {
            amazonS3.getObject(bucket, key);
        } catch (AmazonServiceException e) {
            System.out.println("false");
        }
        System.out.println("true");
    }

    @Test
    public void fileToHash() {
        String offerId = "8e296a067a37563370ded05f5a3bf3ec";
        String hashKey = DigestUtils.md5DigestAsHex(offerId.getBytes());

        log.info("hash : {}", hashKey);

    }
}
