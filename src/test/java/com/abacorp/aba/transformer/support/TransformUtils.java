package com.abacorp.aba.transformer.support;

import com.abacorp.aba.model.offer.TemporaryAbaOffer;
import com.abacorp.aba.model.mapper.TypeMapper;
import com.abacorp.aba.model.type.FacilityCostCategoryType;
import com.abacorp.aba.model.type.ManagementCategoryType;
import com.abacorp.aba.model.type.OptionType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Slf4j
@Service
public class TransformUtils {

    @Autowired
    private DataFactory factory;

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

    public <T extends TypeMapper> String transferCategories(TemporaryAbaOffer abaOffer, Class<T> clazz) {
        boolean isOfficeType = abaOffer.getGubun().equals("5") || abaOffer.getGubun().equals("7");
        String options = abaOffer.getOptions();
        String manages = abaOffer.getManagementCategories();

        if (options.isEmpty()) {
            return null;
        }

        if (manages.isEmpty()) {
            return null;
        }

        List<? extends TypeMapper> TypeLists = factory.getTypeArray(clazz);

        String[] stream = null;

        if (clazz.equals(OptionType.class)) {
           stream = abaOffer.getOptions().split("/");
        } else if (clazz.equals(ManagementCategoryType.class)) {
           stream = isOfficeType ?
                   abaOffer.getOptions().split("/") :
                   abaOffer.getManagementCategories().split("/");
        } else if (clazz.equals(FacilityCostCategoryType.class)) {
           stream = abaOffer.getManagementCategories().split("/");
        }

        return Arrays.stream(stream)
                .map((str) -> {
                    int optionIndex = 0;

                    if (clazz.equals(OptionType.class)) {
                        optionIndex = TypeLists.indexOf(OptionType.createWithValue(str));
                    } else if (clazz.equals(ManagementCategoryType.class)) {
                        optionIndex = TypeLists.indexOf(ManagementCategoryType.createWithValue(str));
                    } else if (clazz.equals(FacilityCostCategoryType.class)) {
                        optionIndex = TypeLists.indexOf(FacilityCostCategoryType.createWithValue(str));
                    }

                    return String.valueOf(optionIndex);
                })
                .collect(Collectors.joining(","));
    }

    public boolean convertTextToBool(String actual, String matcher) {
        if (actual == null) {
            return false;
        }

        return actual.trim().equals(matcher);
    }

    public String getBuildingNameAtTitle(TemporaryAbaOffer abaOffer) {
        String abaTitle = abaOffer.getTitle();
        String result = abaTitle.replaceAll("^.*\\w", "").trim();
        result = result.replaceAll("(\\[.+])", "").trim();
        return result.length() == 0 ? null : result;
    }

    public String getTextAtHtmlString(String htmlString) {
        if (htmlString.isEmpty()) {
            return null;
        }

        String regex = "(<p><span style=\"font-size:.?..px;\">|</span></p>|<p>|</p>)";
        return htmlString.replaceAll(regex, "").trim();
    }

    public String getFloorIfRooftopOrSemibasement(String ho) {
        if (ho == null) {
            return null;
        }

        if (ho.contains("반지하")) {
            return "-100";
        } else if (ho.contains("옥탑")) {
            return "100";
        }

        return null;
    }

    public String convertParamsChildhoodInfo(String ... params) {
        return Stream.of(params)
                .map((str) -> {
                    String noneInfo = "정보없음";
                    if (str == null) {
                        return noneInfo;
                    }

                    if (str.isEmpty()) {
                        return noneInfo;
                    }

                    return str;
                })
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

    public String joiningMultiTelNumber(TemporaryAbaOffer abaOffer) {
        String tels = "";

        String secondTel = abaOffer.getMPhone2();
        String thirdTel = abaOffer.getMPhone3();

        if (!isStrEmptyOrNull(secondTel)) {
            tels = tels.concat(secondTel);

            if (!isStrEmptyOrNull(thirdTel)) {
                tels = tels.concat(", " + thirdTel);
            }
        }

        return tels;
    }

    public String convertEmptyStringToNull(String value) {
        if (value == null) {
            return null;
        }

        if (value.isEmpty()) {
            return null;
        }

        else {
            return value;
        }
    }

    private boolean isStrEmptyOrNull(String matcher) {
        if (matcher == null) {
            return true;
        }

        if (matcher.isEmpty()) {
            return true;
        }

        return false;
    }
}
