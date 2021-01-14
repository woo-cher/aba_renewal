package com.abacorp.aba.transformer.support;

import com.abacorp.aba.model.offer.Offer;
import com.abacorp.aba.model.offer.TemporaryAbaOffer;

public interface TransformStrategy {
    Offer transform(TemporaryAbaOffer abaOffer);
}
