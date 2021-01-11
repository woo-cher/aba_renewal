package com.abacorp.aba.transformer;

import com.abacorp.aba.model.Offer;
import com.abacorp.aba.model.TemporaryAbaOffer;
import com.abacorp.aba.transformer.support.OfferTransformTemplate;
import com.abacorp.aba.transformer.support.TransformStrategy;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AptSaleTransformer extends OfferTransformTemplate implements TransformStrategy {
    @Override
    public Offer transform(TemporaryAbaOffer abaOffer) {
        return null;
    }
}
