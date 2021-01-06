package com.abacorp.aba;

import com.abacorp.aba.core.repository.TransformerRepository;
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
public class TransferAbaOffers {

    @Autowired
    private TransformerRepository repository;

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
        return Stream.of(abaOffer.getDou(), abaOffer.getSi(), abaOffer.getDong(), abaOffer.getJibunAddr())
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
}
