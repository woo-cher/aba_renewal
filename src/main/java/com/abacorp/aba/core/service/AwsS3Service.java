package com.abacorp.aba.core.service;

import com.abacorp.aba.model.dto.KeyValueDto;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;
import org.springframework.util.MimeType;
import org.springframework.web.multipart.MultipartFile;

import javax.activation.MimetypesFileTypeMap;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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
    public final String S3_END_POINT = "https://abasystem.s3.ap-northeast-2.amazonaws.com/";

    @Autowired
    private AmazonS3 amazonS3;

    @Value("${aws.images.prefix}")
    private String pathEndPoint;

    @Value("${aws.bucket}")
    private String bucketName;

    public void upload(List<MultipartFile> multipartFiles, String offerId) throws IOException {
        log.info("directory [offerIdHash] : {}", offerId);
        String hashIdValue = getMd5Hash(offerId);
        String hashFileName = "";
        ObjectMetadata metadata = new ObjectMetadata();

        for(MultipartFile file : multipartFiles) {
            String fileName = file.getOriginalFilename();
            log.info("파일명 : {}", fileName);

            hashFileName = getMd5Hash(fileName);
            log.info("File is hashed (md5) : {}", hashFileName);

            metadata.setContentType(file.getContentType());
            metadata.setContentLength(file.getSize());

            String key = pathEndPoint + hashIdValue + "/" + hashFileName;

            PutObjectRequest req = new PutObjectRequest(bucketName, key, file.getInputStream(), metadata);
            amazonS3.putObject(req.withCannedAcl(CannedAccessControlList.PublicRead));
        }
    }

    /**
     * @param files
     * @param offerId
     * @return Thumbnail File name (Just First index file)
     */
    public String uploadForAbaTransfer(List<File> files, String offerId) {
        String hashIdValue = getMd5Hash(offerId);
        String hashFileName = null;
        String thumbnail = null;

        int i = 0;
        for (File file : files) {
            hashFileName = getMd5Hash(file.getName());

            if (i == 0) {
                thumbnail = hashIdValue + "/" + hashFileName;
            }

            String key = pathEndPoint + hashIdValue + "/" + hashFileName;
            PutObjectRequest req = new PutObjectRequest(bucketName, key, file);
            amazonS3.putObject(req.withCannedAcl(CannedAccessControlList.PublicRead));
            i++;
        }

        return thumbnail;
    }

    // TODO) 삭제 요청한 사진이 썸네일로 지정되어 있으면, 해당 썸네일 컬럼을 비워야 한다.
    public void deleteOne(String hashedOfferId, String fileName) {
        String key = pathEndPoint + hashedOfferId + "/" + fileName;

        amazonS3.deleteObject(bucketName, key);
    }

    public void deleteAll(String offerId) {
        ObjectListing objectListing = getAwsObjectList(offerId);

        while (true) {
            for (S3ObjectSummary objectSummary : objectListing.getObjectSummaries()) {
                amazonS3.deleteObject(bucketName, objectSummary.getKey());
            }
            if (objectListing.isTruncated()) {
                objectListing = amazonS3.listNextBatchOfObjects(objectListing);
            } else {
                break;
            }
        }
    }

    public List<KeyValueDto> getAllFileUrls(String offerId) {
        ObjectListing objectListing = getAwsObjectList(offerId);

        List<KeyValueDto> fileUrls = new ArrayList<>();
        String offerIdAsMd5 = getMd5Hash(offerId);

        while (true) {
            for (S3ObjectSummary objectSummary : objectListing.getObjectSummaries()) {
                String fileKey = objectSummary.getKey();
                String fileName = fileKey.replace("offer-images/", "")
                        .replace(offerIdAsMd5 + "/", "");

                fileUrls.add(new KeyValueDto(fileName, S3_END_POINT + fileKey));
            }
            if (objectListing.isTruncated()) {
                objectListing = amazonS3.listNextBatchOfObjects(objectListing);
            } else {
                break;
            }
        }

        return fileUrls;
    }

    public String getMd5Hash(String value) {
        return DigestUtils.md5DigestAsHex(value.getBytes());
    }

    public ObjectListing getAwsObjectList(String offerId) {
        ListObjectsRequest req = new ListObjectsRequest()
                .withBucketName(bucketName)
                .withPrefix(pathEndPoint + getMd5Hash(offerId));

        return amazonS3.listObjects(req);
    }

    public boolean isExistFile(String hashedOfferId, String fileName) {
        String key = pathEndPoint + hashedOfferId + "/" + fileName;

        try {
            amazonS3.getObject(bucketName, key);
        } catch (AmazonServiceException e) {
            return false;
        }

        return true;
    }
}
