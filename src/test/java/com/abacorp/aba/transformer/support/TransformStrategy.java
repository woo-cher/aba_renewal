package com.abacorp.aba.transformer.support;

import com.abacorp.aba.model.offer.Offer;
import com.abacorp.aba.model.offer.TemporaryAbaOffer;
import org.springframework.stereotype.Component;

@Component
public interface TransformStrategy <T extends OfferTransformTemplate> {
    Offer transform(TemporaryAbaOffer abaOffer);
}
