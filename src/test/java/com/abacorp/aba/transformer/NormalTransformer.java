package com.abacorp.aba.transformer;

import com.abacorp.aba.model.Offer;
import com.abacorp.aba.model.TemporaryAbaOffer;
import com.abacorp.aba.model.type.ManagementCategoryType;
import com.abacorp.aba.model.type.OptionType;
import com.abacorp.aba.transformer.support.OfferTransformTemplate;
import com.abacorp.aba.transformer.support.TransformStrategy;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class NormalTransformer extends OfferTransformTemplate implements TransformStrategy {

    @Override
    public Offer transform(TemporaryAbaOffer abaOffer) {
        initialize(abaOffer);

//        offer.setMonthlyPrice(abaOffer.getMonthly());
//        offer.setManagementPrice(abaOffer.getManageOrProfit());
        offer.setCompletionYear(abaOffer.getCompletionYear());
        offer.setDeposit(abaOffer.getDeposit());

        offerAddress.setHo((abaOffer.getHo()));
        offerAddress.setFloor(utils.getFloorIfRooftopOrSemibasement(abaOffer.getHo()));
        offerAddress.setEntrance(abaOffer.getEnter());
        offerAddress.setDoor(abaOffer.getRoom());

        offerAddition.setOptionCategory(utils.transferOptionOrMcategory(abaOffer, OptionType.class));
        offerAddition.setManagementCategory(utils.transferOptionOrMcategory(abaOffer, ManagementCategoryType.class));
        offerAddition.setTenant(abaOffer.getTenant());

        offerAddition.setCanPet(utils.convertPossibleStatusToBool(abaOffer.getPet()));
        offerAddition.setCanParking(utils.convertPossibleStatusToBool(abaOffer.getParking()));
        offerAddition.setHasElevator(utils.isContainsElevatorInMCategories(abaOffer));

        return packaging();
    }
}
