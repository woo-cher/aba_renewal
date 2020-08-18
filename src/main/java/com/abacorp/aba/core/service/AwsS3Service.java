package com.abacorp.aba.core.service;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

/**
 * NOTE: 현, 단순 Read 권한을 부여하고, 외부에서 URL 로 이미지를 읽을 수 있도록 함
 *     > AWS CDN 서버를 구성하고, 이미지 업로드시 디렉터리명, 이미지명을 해쉬 처리하여 암호화 필요
 *     > 외부에서, 정적으로 access 할 수 없도록 private 처리 하고 CDN 서버에서 이미지를 제공 할 수 있도록 함
 *
 * LINK: https://victorydntmd.tistory.com/335
 */
@Service
@Slf4j
public class AwsS3Service {

    @Autowired
    private AmazonS3 amazonS3;

    @Value("${aws.bucket}")
    private String bucketName;

    public void upload(List<MultipartFile> multipartFiles, String offerId) throws IOException {
        log.info("directory [offerId] : {}", offerId);
        ObjectMetadata metadata = new ObjectMetadata();

        for(MultipartFile file : multipartFiles) {
            log.info("file : {}", file.getOriginalFilename());
            metadata.setContentType(file.getContentType());
            metadata.setContentLength(file.getSize());

            String key = offerId + "/" + file.getOriginalFilename();

            PutObjectRequest req = new PutObjectRequest(bucketName, key, file.getInputStream(), metadata);

            amazonS3.putObject(req.withCannedAcl(CannedAccessControlList.PublicRead));
        }
    }

    public void deleteOne(String offerId, String fileName) {
        String key = offerId + "/" + fileName;

        amazonS3.deleteObject(bucketName, key);
    }

    public void deleteAll(String offerId) {
        ListObjectsRequest req = new ListObjectsRequest()
                .withBucketName(bucketName)
                .withPrefix(offerId);

        ObjectListing objectListing = amazonS3.listObjects(req);

        while (true) {
            for (S3ObjectSummary objectSummary : objectListing.getObjectSummaries()) {
                log.info("key : {}", objectSummary.getKey());
                amazonS3.deleteObject(bucketName, objectSummary.getKey());
            }
            if (objectListing.isTruncated()) {
                objectListing = amazonS3.listNextBatchOfObjects(objectListing);
            } else {
                break;
            }
        }
    }
}
