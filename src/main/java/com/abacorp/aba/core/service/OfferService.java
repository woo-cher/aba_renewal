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

        offer.setThumbnail(getThumbnailPath(offer));

        offerRepository.updateOfferThumbnailById(offer);

        log.info("generatedKey : {}", offer.getId());

        offerAddress.setOfferId(offer.getId());
        offerAddition.setOfferId(offer.getId());

        if (offerRepository.insertOfferAddress(offerAddress) == 0) {
            return 0;
        }

        if (offerRepository.insertOfferAddition(offerAddition) == 0) {
            return 0;
        }

        uploadImages(offer);

        return 1;
    }

    @Transactional
    public int updateOffer(Offer offer) throws IOException {
        OfferAddress offerAddress = offer.getOfferAddress();
        OfferAddition offerAddition = offer.getOfferAddition();

        convertOfferAddressData(offerAddress);

        offer.setThumbnail(getThumbnailPath(offer));

        offerRepository.updateOffer(offer);
        offerRepository.updateOfferAddress(offerAddress);
        offerRepository.updateOfferAddition(offerAddition);

        uploadImages(offer);

        return 1;
    }

    @Transactional
    public int deleteOfferById(int offerId) {
        if (offerRepository.deleteOfferById(offerId) == 0) {
            return 0;
        }

        awsS3Service.deleteAll(String.valueOf(offerId));

        return 1;
    }

    private void uploadImages(Offer offer) throws IOException {
        List<MultipartFile> offerImages = offer.getFiles();

        if (offerImages == null) {
            return;
        }

        if (!offerImages.get(0).getOriginalFilename().isEmpty()) {
            awsS3Service.upload(offerImages, String.valueOf(offer.getId()));
        }
    }

    private String getThumbnailPath(Offer offer) {
        String sId = String.valueOf(offer.getId());
        String thumbPrefix = awsS3Service.getMd5Hash(sId);
        String thumbnail = offer.getThumbnail();

        if (thumbnail.contains("png") || thumbnail.contains("jpeg") || thumbnail.contains("jpg")) {
            thumbnail = awsS3Service.getMd5Hash(offer.getThumbnail());
        }

        return thumbPrefix + "/" + thumbnail;
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

    public List<Offer> searchOffers(String keyword) {
        return offerRepository.selectOffersByKeyword(keyword);
    }
}
