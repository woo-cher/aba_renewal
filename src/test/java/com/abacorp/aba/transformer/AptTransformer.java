package com.abacorp.aba.transformer;

import com.abacorp.aba.model.offer.Offer;
import com.abacorp.aba.model.offer.TemporaryAbaOffer;
import com.abacorp.aba.model.type.HeatingMethodType;
import com.abacorp.aba.transformer.support.OfferTransformTemplate;
import com.abacorp.aba.transformer.support.TransformStrategy;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component
@Qualifier("aptAll")
@Slf4j
public class AptTransformer extends OfferTransformTemplate implements TransformStrategy {

    @Override
    public Offer transform(TemporaryAbaOffer abaOffer) {
        initialize(abaOffer);

        offer.setHeatingMethodType(HeatingMethodType.createWhenContainsValue(abaOffer.getInput4())); // 난방방식
        offer.setCompletionYear(abaOffer.getZone1()); // 준공년도
        offer.setSalePrice(abaOffer.getSalePrice()); // 준공년도
        offer.setLoan(abaOffer.getAptLoan()); // 아파트 융자금

        offerAddress.setDong(abaOffer.getDong()); // 해당동
        offerAddress.setFloor(abaOffer.getFloor1()); // 전체층 (해당층은 필요없어 보임: 고층, 저층, 중층, 로얄층)
        offerAddress.setDoor(abaOffer.getExtra13()); // 룸비번
        offerAddress.setHo(abaOffer.getExtra12()); // 호실
        offerAddress.setLandArea(abaOffer.getPyeong()); // 건물 < 땅이므로 -> 공급 면적
        offerAddress.setBuildingArea(abaOffer.getMake()); // 해당건물 -> 전용 면적

        offerAddition.setTerm(null);
        offerAddition.setHouseholds(abaOffer.getPark()); // 총 세대수
        offerAddition.setHasCool(utils.convertTextToBool(abaOffer.getCool(), "유")); // 냉방시설
        offerAddition.setTotalDong(abaOffer.getExtra14()); // 총 동수
        offerAddition.setTotalParking(abaOffer.getTotalNum()); // 총 주차수
        offerAddition.setDirection(abaOffer.getDirection()); // 방향
        offerAddition.setFrontStructure(abaOffer.getTongro()); // 현관구조
        offerAddition.setRooms(abaOffer.getRoom_num()); // 방개수
        offerAddition.setBathrooms(abaOffer.getPrice7()); // 욕실개수
        offerAddition.setTenant(abaOffer.getExtra7().trim()); // 계약상태 (str => 주인거주중, 비어있음, 세입자있음)
        offerAddition.setBuiltIn(utils.convertTextToBool(abaOffer.getExtra9(), "Yes")); // 확장여부 (`str` to `bool` => Yes/no)
        offerAddition.setMoveIn(abaOffer.getExtra10()); // 입주가능일 (str => 즉시입주, 날짜협의)
        offerAddition.setRemodeling(utils.convertTextToBool(abaOffer.getExtra11(), "Yes")); // 확장여부 (`str` to `bool` => Yes/no)

        return packaging();
    }
}
