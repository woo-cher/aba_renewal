package com.abacorp.aba.transformer.support;

import com.abacorp.aba.model.Offer;
import com.abacorp.aba.model.TemporaryAbaOffer;

public interface TransformStrategy {
    public Offer transform(TemporaryAbaOffer abaOffer);
}
