package com.abacorp.aba.transformer;

import com.abacorp.aba.model.offer.Offer;
import com.abacorp.aba.model.offer.TemporaryAbaOffer;
import com.abacorp.aba.model.type.ManagementCategoryType;
import com.abacorp.aba.model.type.OptionType;
import com.abacorp.aba.transformer.support.OfferTransformTemplate;
import com.abacorp.aba.transformer.support.TransformStrategy;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component
@Qualifier("normalRental")
@Slf4j
public class NormalRentalTransformer extends OfferTransformTemplate implements TransformStrategy {

    @Override
    public Offer transform(TemporaryAbaOffer abaOffer) {
        initialize(abaOffer);

        offer.setMonthlyPrice(abaOffer.getMonthly());
        offer.setManagementPrice(abaOffer.getManageOrProfit());
        offer.setCompletionYear(abaOffer.getExtra8());
        offer.setDeposit(abaOffer.getDeposit());

        offerAddress.setHo(abaOffer.getExtra12());
        offerAddress.setEntrance(abaOffer.getExtra4());
        offerAddress.setDoor(abaOffer.getExtra13());
        offerAddress.setFloor(utils.getFloorIfRooftopOrSemibasement(abaOffer.getExtra12()));

        offerAddition.setRooms(abaOffer.getExtra6()); // 주택 : 방개수, 그외 : 원룸, 투룸, 쓰리룸 ..
        offerAddition.setOptionCategory(utils.transferCategories(abaOffer, OptionType.class));
        offerAddition.setManagementCategory(utils.transferCategories(abaOffer, ManagementCategoryType.class));
        offerAddition.setTenant(abaOffer.getExtra11());

        offerAddition.setCanPet(utils.convertTextToBool(abaOffer.getExtra14(), "가능"));
        offerAddition.setCanParking(utils.convertTextToBool(abaOffer.getExtra15(), "가능"));
        offerAddition.setHasElevator(utils.isContainsElevatorInMCategories(abaOffer));

        offerAddition.setTerm(abaOffer.getExtra10()); // 단기
        if (abaOffer.getExtra10() != null) {
            if (abaOffer.getExtra10().equals("불가능")) {
                offerAddition.setTerm(null);
            }
        }

        return packaging();
    }
}
