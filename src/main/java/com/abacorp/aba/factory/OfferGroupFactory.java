package com.abacorp.aba.factory;

import com.abacorp.aba.model.offer.group.*;
import com.abacorp.aba.model.type.DealType;
import com.abacorp.aba.model.type.OfferType;
import org.springframework.beans.factory.annotation.Autowired;

public class OfferGroupFactory <G extends GroupMapper> {

    @Autowired
    private AptGroup aptGroup;

    @Autowired
    private OfficeGroup officeGroup;

    @Autowired
    private RentalGroup rentalGroup;

    @Autowired
    private SaleGroup saleGroup;

    public G groupCreator(OfferType offerType, DealType dealType) {
        if (offerType.equals(OfferType.APT) || offerType.equals(OfferType.EFFICIENCY_APT)) {
           return (G) aptGroup;
        } else if (dealType.equals(DealType.SALE)) {
           return (G) saleGroup;
        } else {
            if (offerType.equals(OfferType.SHOP) || offerType.equals(OfferType.OFFICE)) {
                 return (G) officeGroup;
            } else {
                return (G) rentalGroup;
            }
        }
    }
}
