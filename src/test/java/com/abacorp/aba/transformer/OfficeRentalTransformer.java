package com.abacorp.aba.transformer;

import com.abacorp.aba.model.offer.Offer;
import com.abacorp.aba.model.offer.TemporaryAbaOffer;
import com.abacorp.aba.model.type.FacilityCostCategoryType;
import com.abacorp.aba.model.type.ManagementCategoryType;
import com.abacorp.aba.transformer.support.OfferTransformTemplate;
import com.abacorp.aba.transformer.support.TransformStrategy;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component
@Qualifier("officeRental")
@Slf4j
public class OfficeRentalTransformer extends OfferTransformTemplate implements TransformStrategy {

    @Override
    public Offer transform(TemporaryAbaOffer abaOffer) {
        initialize(abaOffer);

        offer.setSuppliesPrice(abaOffer.getExtra4() == null ? "0" : abaOffer.getExtra4());
        offer.setManagementPrice(abaOffer.getManageOrProfit());

        offerAddress.setBuildingArea(abaOffer.getPyeong());
        offerAddress.setLandArea(abaOffer.getMake());
        offerAddress.setFloor(abaOffer.getExtra7());
        offerAddress.setHo(abaOffer.getMLicence());
        offerAddress.setDoor(abaOffer.getMArea());

        offerAddition.setRooms(abaOffer.getExtra6());
        offerAddition.setIndustry(abaOffer.getUseArea());
        offerAddition.setRestrictedIndustry(abaOffer.getExtra9());
        offerAddition.setOptionCategory(utils.transferCategories(abaOffer, FacilityCostCategoryType.class));
        offerAddition.setManagementCategory(utils.transferCategories(abaOffer, ManagementCategoryType.class));

        return packaging();
    }
}
