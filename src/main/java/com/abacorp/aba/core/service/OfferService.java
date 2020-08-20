package com.abacorp.aba.core.service;

import com.abacorp.aba.core.repository.OfferRepository;
import com.abacorp.aba.model.Offer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Slf4j
public class OfferService {

    @Autowired
    private OfferRepository offerRepository;

    @Autowired
    private AwsS3Service awsS3Service;

    @Transactional
    public int createOffer(Offer offer) {

        /**
         * NOTE)
         *  1. belongsTo 서비스 로직 (O)
         *  2. images path 필드 추가 / 업로드 처리 로직
         */
        String belongsTo = convertJibunToBelongsTo(offer.getOfferAddress().getJibun());
        offer.getOfferAddress().setBelongsTo(belongsTo);

        // do something ...

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
}
