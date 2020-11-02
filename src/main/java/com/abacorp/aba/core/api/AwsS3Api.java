package com.abacorp.aba.core.api;

import com.abacorp.aba.core.service.AwsS3Service;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/apis")
@Slf4j
public class AwsS3Api {

    @Autowired
    private AwsS3Service s3Service;

    @RequestMapping("/s3/delete")
    private void deleteObject(@RequestParam String offerId, @RequestParam String fileName) {
        log.info("Id & fileName : {}, {}", offerId, fileName);

        s3Service.deleteOne(s3Service.getMd5Hash(offerId), fileName);
    }
}
