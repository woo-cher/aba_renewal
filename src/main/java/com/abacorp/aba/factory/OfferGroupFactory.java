package com.abacorp.aba.factory;

import com.abacorp.aba.model.offer.group.*;
import com.abacorp.aba.model.type.DealType;
import com.abacorp.aba.model.type.OfferType;

public class OfferGroupFactory <G extends GroupMapper> {

    public Class<? extends GroupMapper> groupCreator(OfferType offerType, DealType dealType) {
        if (offerType.equals(OfferType.APT) || offerType.equals(OfferType.EFFICIENCY_APT)) {
           return AptGroup.class;
        } else if (dealType.equals(DealType.SALE)) {
           return SaleGroup.class;
        } else {
            if (offerType.equals(OfferType.SHOP) || offerType.equals(OfferType.OFFICE)) {
                 return OfficeGroup.class;
            } else {
                return RentalGroup.class;
            }
        }
    }
}
