package com.abacorp.aba.transformer.support;

import com.abacorp.aba.model.*;
import com.abacorp.aba.model.offer.Offer;
import com.abacorp.aba.model.offer.OfferAddition;
import com.abacorp.aba.model.offer.OfferAddress;
import com.abacorp.aba.model.offer.TemporaryAbaOffer;
import com.abacorp.aba.model.type.DealType;
import com.abacorp.aba.model.type.HeatingType;
import com.abacorp.aba.model.type.OfferStatusType;
import com.abacorp.aba.model.type.OfferType;
import org.springframework.beans.factory.annotation.Autowired;

public class OfferTransformTemplate extends AbaJsonDataInitializer {

    @Autowired
    protected TransformUtils utils;

    protected Offer offer;
    protected OfferAddress offerAddress;
    protected OfferAddition offerAddition;

    protected void initialize(TemporaryAbaOffer abaOffer) {
        clear();

        String abaOfferType = (String) gubun.get(abaOffer.getGubun());
        String abaDealType = (String) etc1.get(abaOffer.getEtc1());
        String abaStatusType = (String) etc2.get(abaOffer.getEtc2());

        this.offerAddress = OfferAddress.builder()
                .latitude(abaOffer.getLatitude())
                .longitude(abaOffer.getLongitude())
                .buildingName(utils.getBuildingNameAtTitle(abaOffer))
                .jibun(utils.transferJibun(abaOffer))
                .road(utils.transferRoad(abaOffer))
                .dong(utils.getDongIfExist(abaOffer))
                .nearLocation(abaOffer.getInput1())
                .belongsTo(utils.transferBelongsTo(abaOffer))
                .build(); // plus

        this.offerAddition = OfferAddition.builder()
                .term(abaOffer.getExtra10())
                .build();

        this.offer = Offer.builder()
                .abaOfferId(abaOffer.getId())
                .user(User.builder().userId("test").build())
                .deposit(abaOffer.getDeposit())
                .monthlyPrice(abaOffer.getMonthly())
                .inquiryTel(abaOffer.getMPhone())
                .type(OfferType.createWhenContainsValue(abaOfferType))
                .dealType(DealType.createWhenContainsValue(abaDealType))
                .heatingType(HeatingType.createWhenContainsValue(abaOffer.getHot()))
                .status(OfferStatusType.createWhenContainsValue(abaStatusType))
                .adminMemo(abaOffer.getRemarkMemo())
                .description(utils.getTextAtHtmlString(abaOffer.getRemark())) // <p> ... desc ... </p>
                .temporaryImages(abaOffer.getImages())
                .build();
    }

    protected Offer packaging() {
        this.offer.setOfferAddress(this.offerAddress);
        this.offer.setOfferAddition(this.offerAddition);

        return this.offer;
    }

    private void clear() {
        this.offer = Offer.builder().build();
        this.offerAddress = OfferAddress.builder().build();
        this.offerAddition = OfferAddition.builder().build();
    }
}
