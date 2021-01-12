package com.abacorp.aba.transformer;

import com.abacorp.aba.model.offer.Offer;
import com.abacorp.aba.model.offer.TemporaryAbaOffer;
import com.abacorp.aba.transformer.support.OfferTransformTemplate;
import com.abacorp.aba.transformer.support.TransformStrategy;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class OfficeRentalTransformer extends OfferTransformTemplate implements TransformStrategy {
    @Override
    public Offer transform(TemporaryAbaOffer abaOffer) {
        return null;
    }
}
