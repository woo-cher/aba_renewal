package com.abacorp.aba.model.type;

import com.abacorp.aba.model.mapper.TypeMapper;
import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum RequiredConditionType implements TypeMapper {

    UNKNOWN("UNKNOWN"),

    /**
     * 거래 유형
     */
    LOAN("전세자금대출"),
    TRANSPORT("대중교통"),
    ELEVATOR("엘리베이터"),
    PARKING("주차장"),
    FULL_OPTION("풀옵션"),
    NEW("신축"),
    PET("반려동물"),
    SUNLIGHT("일조량"),
    QUITE("조용한"),
    CONVENIENCE_STORE("편의점"),
    STORAGE("수납공간"),
    VERANDA("베란다/발코니"),
    SCHOOL("학군"),
    MANLESS_DELIVERY("개별난방");

    private String value;

    RequiredConditionType(String value) {
        this.value = value;
    }

    @Override
    public String getValue() {
        return value;
    }

    @Override
    public String getCode() {
        return name();
    }

    @Override
    public String toString() {
        return "RequiredConditionType {" +
                "value='" + value + '\'' +
                '}';
    }
}
