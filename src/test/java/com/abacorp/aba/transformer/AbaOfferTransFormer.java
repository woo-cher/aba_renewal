package com.abacorp.aba.transformer;

import com.abacorp.aba.core.repository.OfferRepository;
import com.abacorp.aba.core.repository.TransformerRepository;
import com.abacorp.aba.model.*;
import com.abacorp.aba.model.mapper.TypeMapper;
import com.abacorp.aba.model.type.*;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import java.io.FileReader;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

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
public class AbaOfferTransFormer {

    @Autowired
    private TransformerRepository repository;

    @Autowired
    private OfferRepository offerRepository;

    private JSONObject gubun;
    private JSONObject etc1;
    private JSONObject etc2;

    @Before
    public void setup() throws IOException, ParseException {
        JSONParser parser = new JSONParser();
        JSONObject abaType = (JSONObject) parser.parse(new FileReader("aba-type.json"));

        this.gubun = (JSONObject) abaType.get("gubun");
        this.etc1 = (JSONObject) abaType.get("etc1");
        this.etc2 = (JSONObject) abaType.get("etc2");
    }

    @Test
    public void transferType() {
        log.info("OfferType : {}", OfferType.createWhenContainsValue(gubun.get("61").toString()));
        log.info("DealType : {}", DealType.createWhenContainsValue(etc1.get("1").toString()));
        log.info("StatusType : {}", OfferStatusType.createWhenContainsValue(etc2.get("1").toString()));
        log.info("HeatingType : {}", HeatingType.createWhenContainsValue("LPG"));
    }

    @Test
    @Transactional
    public void oneRoomTransformer() {
        TemporaryAbaOffer mock = repository.selectAbaOffers().get(0);

        String abaOfferType = (String) gubun.get(mock.getOfferTypeCode());
        String abaDealType = (String) etc1.get(mock.getDealTypeCode());
        String abaStatusType = (String) etc2.get(mock.getStatusCode());

        OfferAddress offerAddress = OfferAddress.builder()
                .offerId(mock.getId())
                .latitude(mock.getLatitude())
                .longitude(mock.getLongitude())
                .buildingName(getBuildingNameAtTitle(mock))
                .jibun(transferJibun(mock))
                .road(transferRoad(mock))
                .dong(getDongIfExist(mock))
                .ho(mock.getHo())
                .entrance(mock.getEnter())
                .door(mock.getRoom())
                .floor(getFloorIfRooftopOrSemibasement(mock.getHo())) // 만약 ho 정보에 옥탑이나 반지하면?
                .nearLocation(mock.getNear())
                .belongsTo(transferBelongsTo(mock))
                .build(); // plus

        OfferAddition offerAddition = OfferAddition.builder()
                .offerId(mock.getId())
                .term(mock.getTerm())
                .tenant(mock.getTenant())
                .optionCategory(transferOptionOrMcategory(mock, OptionType.class))
                .managementCategory(transferOptionOrMcategory(mock, ManagementCategoryType.class))
                .hasElevator(false)
                .canParking(convertPossibleStatusToBool(mock.getPet()))
                .canPet(convertPossibleStatusToBool(mock.getParking()))
                .build();

        // null 로 처리 하는 부분 로직 짜야한다.
        Offer offer = Offer.builder()
                .user(User.builder().userId("test").build())
                .deposit(mock.getDeposit())
                .monthlyPrice(mock.getMonthly())
                .managementPrice(mock.getManageOrProfit())
                .inquiryTel(mock.getTel())
                .completionYear(mock.getCompletionYear())
                .type(OfferType.createWhenContainsValue(abaOfferType))
                .dealType(DealType.createWhenContainsValue(abaDealType))
                .heatingType(HeatingType.createWhenContainsValue(mock.getHeatingType()))
                .heatingMethodType(null)
                .status(OfferStatusType.createWhenContainsValue(abaStatusType))
                .adminMemo(mock.getAdminMemo())
                .description(mock.getDescription()) // <p> ... desc ... </p>
                .thumbnail(null)
                .temporaryImages(mock.getImages())
                .build();

        log.info("Offer: {}", offer);
        log.info("OfferAddress: {}", offerAddress);
        log.info("OfferAddition: {}", offerAddition);
    }

    @Test
    public void convertStrToOptionTypes() {
        TemporaryAbaOffer mock = TemporaryAbaOffer.builder()
                .options("에어컨/세탁기/냉장고/가스렌지/침대/붙박이장")
                .managementCategories("수도세/인터넷/유선방송")
                .build();

        log.info("options : {}", transferOptionOrMcategory(mock, OptionType.class));
        log.info("mCategories : {}", transferOptionOrMcategory(mock, ManagementCategoryType.class));
    }

    @Test
    public void transferAddress() {
        TemporaryAbaOffer mock = repository.selectAbaOffers().get(0);

        log.info("jibun : {}", transferJibun(mock));
        log.info("road : {}", transferRoad(mock));
    }

    /**
     * Utils
     */
    private String transferJibun(TemporaryAbaOffer abaOffer) {
        return filteringAndJoining(
                Stream.of(abaOffer.getDou(), abaOffer.getSi(), abaOffer.getDongArea(), abaOffer.getJibunAddr())
        );
    }

    private String transferRoad(TemporaryAbaOffer abaOffer) {
        return filteringAndJoining(
                Stream.of(abaOffer.getDou(), abaOffer.getSi(), abaOffer.getRoadName(), abaOffer.getRoadNum())
        );
    }

    private String transferBelongsTo(TemporaryAbaOffer abaOffer) {
        return filteringAndJoining(
                Stream.of(abaOffer.getDou(), abaOffer.getSi(), abaOffer.getDongArea())
        );
    }

    private String filteringAndJoining(Stream<String> stream) {
        return stream
                .map((str) -> str.replace("경상남도", "경남"))
                .collect(Collectors.joining(" "))
                .trim();
    }

    private <T extends TypeMapper> String transferOptionOrMcategory(TemporaryAbaOffer abaOffer, Class<T> clazz) {
        boolean isOptionType = clazz.equals(OptionType.class);

        List<TypeMapper> TypeLists = isOptionType ?
                Arrays.asList(OptionType.values()) :
                Arrays.asList(ManagementCategoryType.values());

        String[] stream = isOptionType ?
                abaOffer.getOptions().split("/") :
                abaOffer.getManagementCategories().split("/");

        return Arrays.stream(stream)
                .map((str) -> {
                    int optionIndex = isOptionType ?
                            TypeLists.indexOf(OptionType.createWithValue(str)) :
                            TypeLists.indexOf(ManagementCategoryType.createWithValue(str));

                    return String.valueOf(optionIndex);
                })
                .collect(Collectors.joining(","));
    }

    private boolean convertPossibleStatusToBool(String possibleStatus) {
        return possibleStatus.equals("가능");
    }

    private String getBuildingNameAtTitle(TemporaryAbaOffer abaOffer) {
        String abaTitle = abaOffer.getTitle();
        String result = abaTitle.replaceAll("^.*\\w", "").trim();
        return result.length() == 0 ? null : result;
    }

    private String getDongIfExist(TemporaryAbaOffer abaOffer) {
        String dong = abaOffer.getDong();
        return dong.length() == 0 ? null : dong;
    }

    private String getTextAtHtmlString(String htmlString) {
        String regex = "(<p><span style=\"font-size:.?28px;\">|</span></p>)";

        return htmlString.replaceAll(regex, "");
    }

    private String getFloorIfRooftopOrSemibasement(String ho) {
        if (ho.contains("반지하")) {
            return "-100";
        } else if (ho.contains("옥탑")) {
            return "100";
        }

        return null;
    }
}
