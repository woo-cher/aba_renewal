package com.abacorp.aba.transformer.support;

import com.abacorp.aba.model.offer.TemporaryAbaOffer;
import com.abacorp.aba.model.mapper.TypeMapper;
import com.abacorp.aba.model.type.ManagementCategoryType;
import com.abacorp.aba.model.type.OptionType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Slf4j
@Service
public class TransformUtils {

    public String transferJibun(TemporaryAbaOffer abaOffer) {
        return filteringAndJoining(
                Stream.of(abaOffer.getArea1(), abaOffer.getArea2(), abaOffer.getAddr(), abaOffer.getAddr2())
        );
    }

    public String transferRoad(TemporaryAbaOffer abaOffer) {
        return filteringAndJoining(
                Stream.of(abaOffer.getArea1(), abaOffer.getArea2(), abaOffer.getJuso1(), abaOffer.getJuso2())
        );
    }

    public String transferBelongsTo(TemporaryAbaOffer abaOffer) {
        return filteringAndJoining(
                Stream.of(abaOffer.getArea1(), abaOffer.getArea2(), abaOffer.getAddr())
        );
    }

    public String filteringAndJoining(Stream<String> stream) {
        return stream
                .map((str) -> str.replace("경상남도", "경남"))
                .collect(Collectors.joining(" "))
                .trim();
    }

    public <T extends TypeMapper> String transferOptionOrMcategory(TemporaryAbaOffer abaOffer, Class<T> clazz) {
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

    public boolean convertPossibleStatusToBool(String possibleStatus) {
        return possibleStatus.equals("가능");
    }

    public boolean convertExistTextToBool(String isExistString) {
        return isExistString.equals("있음");
    }

    public String getBuildingNameAtTitle(TemporaryAbaOffer abaOffer) {
        String abaTitle = abaOffer.getTitle();
        String result = abaTitle.replaceAll("^.*\\w", "").trim();
        return result.length() == 0 ? null : result;
    }

    public String getDongIfExist(TemporaryAbaOffer abaOffer) {
        String dong = abaOffer.getDong();
        return dong.length() == 0 ? null : dong;
    }

    public String getTextAtHtmlString(String htmlString) {
        if (htmlString.isEmpty()) {
            return null;
        }

        String regex = "(<p><span style=\"font-size:.?28px;\">|</span></p>)";
        return htmlString.replaceAll(regex, "");
    }

    public String getFloorIfRooftopOrSemibasement(String ho) {
        if (ho.contains("반지하")) {
            return "-100";
        } else if (ho.contains("옥탑")) {
            return "100";
        }

        return null;
    }

    public String convertParamsChildhoodInfo(String ... params) {
        return Stream.of(params)
                .map((str) -> str.isEmpty() ? "정보없음" : str)
                .collect(Collectors.joining("/"));
    }

    public boolean isContainsElevatorInMCategories(TemporaryAbaOffer abaOffer) {
        if (abaOffer.getManagementCategories() == null) {
            throw new NullPointerException("Management Categories is Null");
        }

        List<ManagementCategoryType> categoryList = Arrays.asList(ManagementCategoryType.values());
        int elevatorTypeIndex = categoryList.indexOf(ManagementCategoryType.ELEVATOR);

        return abaOffer.getManagementCategories().contains(String.valueOf(elevatorTypeIndex));
    }
}
