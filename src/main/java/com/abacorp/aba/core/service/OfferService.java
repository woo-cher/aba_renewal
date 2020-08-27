package com.abacorp.aba.core.service;

import com.abacorp.aba.core.repository.OfferRepository;
import com.abacorp.aba.model.Offer;
import com.abacorp.aba.model.OfferAddition;
import com.abacorp.aba.model.OfferAddress;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.FieldError;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

// TODO) insert, delete, update row 가 0을 리턴하는 경우, Exception 처리
@Service
@Slf4j
public class OfferService {

    @Autowired
    private OfferRepository offerRepository;

    @Autowired
    private AwsS3Service awsS3Service;

    @Transactional
    public int createOffer(Offer offer) throws IOException {
        OfferAddress offerAddress = offer.getOfferAddress();
        OfferAddition offerAddition = offer.getOfferAddition();

        String belongsTo = convertJibunToBelongsTo(offerAddress.getJibun());
        offerAddress.setBelongsTo(belongsTo);

        String floorType = offerAddress.getFloor();
        offerAddress.setFloor(convertFloor(floorType));

        if(offerRepository.insertOffer(offer) == 0) {
            return 0;
        }

        log.info("generatedKey : {}", offer.getId());

        offerAddress.setOfferId(offer.getId());
        offerAddition.setOfferId(offer.getId());

        if(offerRepository.insertOfferAddress(offerAddress) == 0) {
            return 0;
        }

        if(offerRepository.insertOfferAddition(offerAddition) == 0) {
            return 0;
        }

        /**
         * TODO) images path 필드 추가 / 업로드 처리 로직
         */
        List<MultipartFile> offerImages = offer.getFiles();

        if(!offerImages.get(0).getOriginalFilename().isEmpty()) {
            String thumbnail = awsS3Service.upload(offerImages, String.valueOf(offer.getId()));
            offer.setThumbnail(thumbnail);

            offerRepository.updateOfferThumbnailById(offer);
        }

        return 1;
    }

    public int deleteOffer(int offerId) {
        if(offerRepository.deleteOfferById(offerId) == 0) {
            return 0;
        }

        return 1;
    }

    /**
     * For example, `jibun` : "경남 진주시 호탄동 619-1"
     * As a result, `belongsTo` -> "경남 진주시 호탄동"
     *
     * @param jibunAddress
     */
    private String convertJibunToBelongsTo(String jibunAddress) {
        String regex = "[0-9\\\\-]";

        String result = jibunAddress.replaceAll(regex, "");

        // For remove the last string is `blank`
        return result.substring(0, result.length() - 1);
    }

    private String convertFloor(String floorType) {
        String floor = "";

        switch (floorType) {
            case "반지하":
                floor = "-1";
                break;
            case "옥탑":
                floor = "100";
                break;
            default:
                floor = floorType;
                break;
        }

        return floor;
    }

    public int getCreateProcessIndex(List<FieldError> errors) {
        Map<String, Boolean> clazzMap = new HashMap<>();

        clazzMap.put("offer", false);
        clazzMap.put("offerAddress", false);
        clazzMap.put("offerAddition", false);

        for(FieldError error : errors) {
            if(error.getField().contains("offerAddress")) {
                clazzMap.put("offerAddress", true);
            } else if(error.getField().contains("offerAddition")) {
                clazzMap.put("offerAddition", true);
            } else {
                clazzMap.put("offer", true);
            }
        }

        if(clazzMap.get("offer")) {
            return 0;
        } else if(clazzMap.get("offerAddress")) {
            return 1;
        } else {
            return 2;
        }
    }
}
