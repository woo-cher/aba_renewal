package com.abacorp.aba.transformer;

import com.abacorp.aba.model.offer.Offer;
import com.abacorp.aba.model.offer.TemporaryAbaOffer;
import com.abacorp.aba.transformer.support.OfferTransformTemplate;
import com.abacorp.aba.transformer.support.TransformStrategy;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class NormalSaleTransformer extends OfferTransformTemplate implements TransformStrategy {
    @Override
    public Offer transform(TemporaryAbaOffer abaOffer) {
        initialize(abaOffer);

        offer.setLoan(abaOffer.getLoan());
        offer.setSalePrice(abaOffer.getSalePrice());
        offer.setInvestmentMoney(abaOffer.getInvestmentPrice());
        offer.setInterest(abaOffer.getExtra13());
        offer.setMonthlyProfit(abaOffer.getManageOrProfit());

        offer.setCompletionYear(abaOffer.getZone1());

        offerAddress.setFloor(abaOffer.getExtra5());
        offerAddress.setBuildingArea(abaOffer.getPyeong());
        offerAddress.setLandArea(abaOffer.getMake());

        offerAddition.setHasElevator(utils.convertExistTextToBool(abaOffer.getExtra4()));
        offerAddition.setHouseholdInfo(
                // 지하/1층/.../6층 세대
                utils.convertParamsChildhoodInfo(
                        abaOffer.getExtra12(), abaOffer.getExtra6(), abaOffer.getExtra7(), abaOffer.getExtra8(),
                        abaOffer.getExtra9(), abaOffer.getExtra10(), abaOffer.getExtra11()
                )
        );

        return packaging();
    }
}
