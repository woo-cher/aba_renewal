package com.abacorp.aba.transformer;

import com.abacorp.aba.core.repository.OfferRepository;
import com.abacorp.aba.core.service.AwsS3Service;
import com.abacorp.aba.model.offer.Offer;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
//@RunWith(JUnit4.class)
@Slf4j
public class AbaImageUploadTest {
    private final String END_POINT = "C:/Users/ABA_System_WC/Desktop/upload/";

    @Autowired
    private AwsS3Service s3Service;

    @Autowired
    private OfferRepository offerRepository;

    @Test
    public void upload() {
        List<Offer> offers = offerRepository.selectStatusOnOffers();

        int i = 0;
        for (Offer offer : offers) {
            if (i == 1) return;

            String imageUrls = offer.getTemporaryImages();
            log.info("offer {} -> images : {}", offer.getId(), imageUrls);
            List<File> files = new ArrayList<>();
            List<String> imageUrlLists = Arrays.asList(imageUrls.split(","));

            for (String url : imageUrlLists) {
                File file = new File(END_POINT + url);

                if (file.exists()) {
                    files.add(file);
                }
            }

            String thumbnail = s3Service.uploadForAbaTransfer(files, String.valueOf(offer.getId()));
            log.info("thumbnail : {}", thumbnail);

            if (thumbnail != null) {
                offer.setThumbnail(thumbnail);
                offerRepository.updateOfferThumbnailById(offer);
            }

            i++;
        }
    }
}
