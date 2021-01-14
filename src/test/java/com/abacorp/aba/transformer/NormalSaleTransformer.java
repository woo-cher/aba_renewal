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

        offerAddress.setFloor(abaOffer.getExtra5());

        offerAddition.setHasElevator(utils.convertExistTextToBool(abaOffer.getExtra4()));

        return packaging();
    }
}
