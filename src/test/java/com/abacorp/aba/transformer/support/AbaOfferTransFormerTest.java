package com.abacorp.aba.transformer.support;

import com.abacorp.aba.core.repository.TransformerRepository;
import com.abacorp.aba.model.offer.Offer;
import com.abacorp.aba.model.offer.OfferAddition;
import com.abacorp.aba.model.offer.OfferAddress;
import com.abacorp.aba.model.offer.TemporaryAbaOffer;
import com.abacorp.aba.model.type.FacilityCostCategoryType;
import com.abacorp.aba.model.type.ManagementCategoryType;
import com.abacorp.aba.model.type.OfferType;
import com.abacorp.aba.model.type.OptionType;
import com.abacorp.aba.transformer.NormalRentalTransformer;
import com.abacorp.aba.transformer.NormalSaleTransformer;
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
    private TransformerRepository repository;

    @Autowired
    private DataFactory factory;

    @Test
    @Transactional
    public void transformTest() {
        TemporaryAbaOffer mock = repository.selectAbaOffers().get(0);
        TransformStrategy strategy = factory.getTransformer(mock);

        Offer target = strategy.transform(mock);
        log.info("target : {}", target);
    }

    @Test
    public void convertStrToOptionTypes() {
        TemporaryAbaOffer mock = TemporaryAbaOffer.builder()
                .gubun("61")
                .options("에어컨/세탁기/냉장고/가스렌지/침대/붙박이장")
                .managementCategories("수도세/인터넷/유선방송")
                .build();

        TemporaryAbaOffer mock2 = TemporaryAbaOffer.builder()
                .gubun("5")
                .options("건물청소비/공용전기")
                .managementCategories("인테리어비용/기타")
                .build();

        log.info("options : {}", utils.transferCategories(mock, OptionType.class));
        log.info("mCategories : {}", utils.transferCategories(mock, ManagementCategoryType.class));

        log.info("office management : {}", utils.transferCategories(mock2, ManagementCategoryType.class));
        log.info("office facility : {}", utils.transferCategories(mock2, FacilityCostCategoryType.class));
    }

    @Test
    public void transferAddress() {
        TemporaryAbaOffer mock = repository.selectAbaOffers().get(0);

        log.info("jibun : {}", utils.transferJibun(mock));
        log.info("road : {}", utils.transferRoad(mock));
    }

    @Test
    public void getType() {
        String case1 = "건물/원룸";
        String case2 = "주택/단독";

        log.info("{}", OfferType.createWhenContainsValue(case1));
        log.info("{}", OfferType.createWhenContainsValue(case2));
    }

    @Test
    public void joiningChildhoodInfo() {
        String str1 = "";
        String str2 = "원룸";
        String str3 = "쓰리룸";
        String str4 = "";
        String str5 = "주인세대";

        String result = utils.convertParamsChildhoodInfo(str2, str1, str3, str4, str5);
        String[] strs = result.split("/");

        log.info("result {}", result);
        log.info("size is {}", strs.length);
        for (String s : strs) {
            System.out.println(s);
        }
    }

    @Test
    public void joiningTel() {
        TemporaryAbaOffer abaOffer = TemporaryAbaOffer.builder()
                .mPhone("010-1234-1234")
                .remarkMemo(null)
                .mPhone2("010-1234-1111")
                .mPhone3(null)
                .build();

        String otherPhones = utils.joiningMultiTelNumber(abaOffer);
        log.info("{}", otherPhones);

        if (!otherPhones.isEmpty()) {
           String adminMemo = abaOffer.getRemarkMemo() == null ?
                   "" : abaOffer.getRemarkMemo();

           adminMemo = adminMemo.isEmpty() ?
                   adminMemo.concat("(추가연락처) -> " + otherPhones) :
                   adminMemo.concat(", (추가연락처) -> " + otherPhones);

           abaOffer.setRemarkMemo(adminMemo);
        }

        log.info("{}", abaOffer.getRemarkMemo());
    }

    @Test
    public void transformerFactory() {
        log.info("상가 {}", factory.getTransformer(TemporaryAbaOffer.builder().gubun("5").build()));
        log.info("사무실 {}", factory.getTransformer(TemporaryAbaOffer.builder().gubun("7").build()));
        log.info("원룸/방 {}", factory.getTransformer(TemporaryAbaOffer.builder().gubun("61").build()));
        log.info("투/쓰리룸 {}", factory.getTransformer(TemporaryAbaOffer.builder().gubun("75").build()));
        log.info("주택/단독, 매매 {}", factory.getTransformer(TemporaryAbaOffer.builder().gubun("57").etc1("1").build()));
        log.info("주택/단독, 월세 {}", factory.getTransformer(TemporaryAbaOffer.builder().gubun("57").etc1("2").build()));
        log.info("주택/단독, 전세 {}", factory.getTransformer(TemporaryAbaOffer.builder().gubun("57").etc1("3").build()));
        log.info("건물/원룸, 매매 {}", factory.getTransformer(TemporaryAbaOffer.builder().gubun("65").build()));
        log.info("건물/상가, 매매 {}", factory.getTransformer(TemporaryAbaOffer.builder().gubun("66").build()));
    }
}
