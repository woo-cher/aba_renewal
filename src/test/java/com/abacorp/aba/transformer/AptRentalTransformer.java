package com.abacorp.aba.transformer;

import com.abacorp.aba.model.offer.Offer;
import com.abacorp.aba.model.offer.TemporaryAbaOffer;
import com.abacorp.aba.transformer.support.OfferTransformTemplate;
import com.abacorp.aba.transformer.support.TransformStrategy;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
public class AptRentalTransformer extends OfferTransformTemplate implements TransformStrategy {
    @Override
    public Offer transform(TemporaryAbaOffer abaOffer) {
        return null;
    }
}
