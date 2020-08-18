package com.abacorp.aba.core.controller;

import com.abacorp.aba.core.service.AwsS3Service;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.util.List;

/**
 * TODO : 커밋 하기전에 로그 정리 하고, 파일 업로드 되는지 확인! 하고 푸쉬먼저 한다. 그런 후에, 차후 작업 생각!!!!!!!!!
 *
 */
@Controller
@RequestMapping("/aws/s3")
@Slf4j
public class AwsS3Controller {

    @Autowired
    private AwsS3Service s3Service;

    @RequestMapping(value = "/upload")
    public String uploadOfferImages(List<MultipartFile> files, String offerIdForDirectory) throws IOException {
        if(files != null) {
            s3Service.upload(files, offerIdForDirectory);
        }

        return "admin/offer_create";
    }
}
