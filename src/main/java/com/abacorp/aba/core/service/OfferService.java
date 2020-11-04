package com.abacorp.aba.core.service;

import com.abacorp.aba.core.repository.OfferRepository;
import com.abacorp.aba.model.Offer;
import com.abacorp.aba.model.OfferAddition;
import com.abacorp.aba.model.OfferAddress;
import com.abacorp.aba.model.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
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

    @Autowired
    private UserService userService;

    @Transactional
    public int createOffer(Offer offer) throws IOException {
        OfferAddress offerAddress = offer.getOfferAddress();
        OfferAddition offerAddition = offer.getOfferAddition();

        convertOfferAddressData(offerAddress);

        if (offerRepository.insertOffer(offer) == 0) {
            return 0;
        }

        log.info("generatedKey : {}", offer.getId());

        offerAddress.setOfferId(offer.getId());
        offerAddition.setOfferId(offer.getId());

        if (offerRepository.insertOfferAddress(offerAddress) == 0) {
            return 0;
        }

        if (offerRepository.insertOfferAddition(offerAddition) == 0) {
            return 0;
        }

        uploadImages(offer, false);

        return 1;
    }

    /**
     * TODO)
     *  1. createOffer() 의 특정 데이터 변환 부 통합 해야 한다
     *  2. Image 처리는 어떻게 할 것인가?
     *  errors.hasError() == false 이면, 기존 Offer 가 가진 s3 이미지를 모두 삭제 처리
     *  그런 후에, 업로드 위한 이미지를 재업로드 한다.
     */
    @Transactional
    public int updateOffer(Offer offer) throws IOException {
        OfferAddress offerAddress = offer.getOfferAddress();
        OfferAddition offerAddition = offer.getOfferAddition();

        convertOfferAddressData(offerAddress);

        offerRepository.updateOffer(offer);
        offerRepository.updateOfferAddress(offerAddress);
        offerRepository.updateOfferAddition(offerAddition);

        uploadImages(offer, true);

        return 1;
    }

    public int deleteOfferById(int offerId) {
        if (offerRepository.deleteOfferById(offerId) == 0) {
            return 0;
        }

        return 1;
    }

    private void uploadImages(Offer offer, boolean isUpdate) throws IOException {
        List<MultipartFile> offerImages = offer.getFiles();

        if (offerImages == null) {
            return;
        }

        if (!offerImages.get(0).getOriginalFilename().isEmpty()) {
            String thumbnail = awsS3Service.upload(offerImages, String.valueOf(offer.getId()));

            /**
             * TODO) 썸네일 로직
             *  매물 수정 모드일 때, 기존 썸네일이 바뀐다.
             */
            if(!isUpdate) {
                offer.setThumbnail(thumbnail);
                offerRepository.updateOfferThumbnailById(offer);
            }
        }
    }

    private String getThumbnailById(int offerId) {
        return offerRepository.selectOfferThumbnail(offerId);
    }

    private void convertOfferAddressData(OfferAddress offerAddress) {
        String belongsTo = convertJibunToBelongsTo(offerAddress.getJibun());
        offerAddress.setBelongsTo(belongsTo);

        String floorType = offerAddress.getFloor();
        offerAddress.setFloor(convertFloor(floorType));
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

    public int getFormProcessIndex(List<FieldError> errors) {
        Map<String, Boolean> clazzMap = new HashMap<>();

        clazzMap.put("offer", false);
        clazzMap.put("offerAddress", false);
        clazzMap.put("offerAddition", false);

        for (FieldError error : errors) {
            if (error.getField().contains("offerAddress")) {
                clazzMap.put("offerAddress", true);
            } else if (error.getField().contains("offerAddition")) {
                clazzMap.put("offerAddition", true);
            } else {
                clazzMap.put("offer", true);
            }
        }

        if (clazzMap.get("offer")) {
            return 0;
        } else if (clazzMap.get("offerAddress")) {
            return 1;
        } else {
            return 2;
        }
    }

    public boolean isOwner(String registerId, User sessionUser) {
        User register = userService.findByUserId(registerId);

        return register.equals(sessionUser);
    }
}
