package com.abacorp.aba.transformer;

import com.abacorp.aba.core.repository.TransformerRepository;
import com.abacorp.aba.model.OfferAddition;
import com.abacorp.aba.model.OfferAddress;
import com.abacorp.aba.model.TemporaryAbaOffer;
import com.abacorp.aba.model.mapper.TypeMapper;
import com.abacorp.aba.model.type.ManagementCategoryType;
import com.abacorp.aba.model.type.OptionType;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@RunWith(SpringRunner.class)
@SpringBootTest
@Slf4j
public class AbaOfferTransFormer {

    @Autowired
    private TransformerRepository repository;

    @Test
    public void finalTransformer() {
        TemporaryAbaOffer mock = repository.selectAbaOffers().get(0);

        OfferAddress offerAddress = OfferAddress.builder()
                .offerId(mock.getId())
                .latitude(mock.getLatitude())
                .longitude(mock.getLongitude())
                .buildingName(getBuildingNameAtTitle(mock))
                .jibun(transferJibun(mock))
                .road(transferRoad(mock))
                .dong(getDongIfExist(mock))
                .ho(mock.getHo())
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

    private String transferJibun(TemporaryAbaOffer abaOffer) {
        return Stream.of(abaOffer.getDou(), abaOffer.getSi(), abaOffer.getDongArea(), abaOffer.getJibunAddr())
                .map((str) -> str.replace("경상남도", "경남"))
                .collect(Collectors.joining(" "));
    }

    private String transferRoad(TemporaryAbaOffer abaOffer) {
        return Stream.of(abaOffer.getDou(), abaOffer.getSi(), abaOffer.getRoadName(), abaOffer.getRoadNum())
                .map((str) -> str.replace("경상남도", "경남"))
                .collect(Collectors.joining(" "));
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
}
