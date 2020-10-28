package com.abacorp.aba.core.service;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;
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
    private final String S3_END_POINT = "https://abasystem.s3.ap-northeast-2.amazonaws.com/";

    @Autowired
    private AmazonS3 amazonS3;

    @Value("${aws.images.prefix}")
    private String pathEndPoint;

    @Value("${aws.bucket}")
    private String bucketName;

    /**
     * `Thumbnail` is the First uploaded image.
     *
     * @param multipartFiles
     * @param offerId
     * @return path: "offerId/thumbnail" (md5)
     * @throws IOException
     */
    public String upload(List<MultipartFile> multipartFiles, String offerId) throws IOException {
        log.info("directory [offerIdHash] : {}", offerId);
        String hashIdValue = getMd5Hash(offerId);
        String hashFileName = "";
        String thumbnail = "";
        ObjectMetadata metadata = new ObjectMetadata();

        int index = 0;
        for(MultipartFile file : multipartFiles) {
            hashFileName = getMd5Hash(file.getOriginalFilename());

            if(index == 0) {
                thumbnail = hashFileName;
            }

            metadata.setContentType(file.getContentType());
            metadata.setContentLength(file.getSize());

            String key = pathEndPoint + hashIdValue + "/" + hashFileName;

            PutObjectRequest req = new PutObjectRequest(bucketName, key, file.getInputStream(), metadata);
            amazonS3.putObject(req.withCannedAcl(CannedAccessControlList.PublicRead));

            index++;
        }

        return (hashIdValue + "/" + thumbnail);
    }

    public void deleteOne(String offerId, String fileName) {
        String key = pathEndPoint + offerId + "/" + fileName;

        amazonS3.deleteObject(bucketName, key);
    }

    public void deleteAll(String offerId) {
        ListObjectsRequest req = new ListObjectsRequest()
                .withBucketName(bucketName)
                .withPrefix(pathEndPoint + getMd5Hash(offerId));

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

    public String getMd5Hash(String value) {
        return DigestUtils.md5DigestAsHex(value.getBytes());
    }
}
