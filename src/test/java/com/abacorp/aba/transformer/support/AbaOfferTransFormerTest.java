package com.abacorp.aba.transformer.support;

import com.abacorp.aba.core.repository.TransformerRepository;
import com.abacorp.aba.model.*;
import com.abacorp.aba.model.type.ManagementCategoryType;
import com.abacorp.aba.model.type.OptionType;
import com.abacorp.aba.transformer.NormalTransformer;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

/**
 *  For transfer {@link TemporaryAbaOffer} to ${@link Offer} {@link OfferAddress} {@link OfferAddition}
 *
 *  NOTE) 아바 매물 유형
 *      field: gubun {
 *          "1": "아파트", "2": "주택", "3": "원룸", "4": "오피스텔", "5": "상가", "6": "건물", "7": "사무실",
 *          "57": "주택/단독", "58": "주택/상가", "59": "주택/전원주택", "60": "주택/빌라|연립", "61": "원룸/방",
 *          "65": "건물/원룸", "66": "건물/상가", "67": "건물/숙박|콘도", "75": "투.쓰리룸"
 *      }
 *
 *   NOTE) 아바 거래 유형
 *      field: etc1 {
 *          "1": "매매", "2": "전세", "3": "월세", "4": "임대"
 *      }
 *      * 임대 데이터가 없긴 하다
 *
 *   NOTE) 아바 매물 상태
 *      field: etc2 {
 *          "0": "진행", "1": "계약완료", "2": "숨김"
 *      }
 *
 * TODO) 위 3개 필드와 리뉴얼에서 제공하는 아래 3개 타입 형태와 일치시켜 값을 대입해야 함
 *
 * @see com.abacorp.aba.model.type.OfferType
 * @see com.abacorp.aba.model.type.DealType
 * @see com.abacorp.aba.model.type.OfferStatusType
 */
@RunWith(SpringRunner.class)
@SpringBootTest
@Slf4j
public class AbaOfferTransFormerTest {

    @Autowired
    private TransformUtils utils;

    @Autowired
    private NormalTransformer offerTransformer;

    @Autowired
    private TransformerRepository repository;

    @Test
    @Transactional
    public void oneRoomTransformer() {
        TemporaryAbaOffer mock = repository.selectAbaOffers().get(0);
        mock.setDescription("<p><span style=\"font-size: 28px;\">2년계약 조건입니다.</span></p>");

        Offer target = offerTransformer.transform(mock);
        log.info("target : {}", target);
    }

    @Test
    public void convertStrToOptionTypes() {
        TemporaryAbaOffer mock = TemporaryAbaOffer.builder()
                .options("에어컨/세탁기/냉장고/가스렌지/침대/붙박이장")
                .managementCategories("수도세/인터넷/유선방송")
                .build();

        log.info("options : {}", utils.transferOptionOrMcategory(mock, OptionType.class));
        log.info("mCategories : {}", utils.transferOptionOrMcategory(mock, ManagementCategoryType.class));
    }

    @Test
    public void transferAddress() {
        TemporaryAbaOffer mock = repository.selectAbaOffers().get(0);

        log.info("jibun : {}", utils.transferJibun(mock));
        log.info("road : {}", utils.transferRoad(mock));
    }
}
