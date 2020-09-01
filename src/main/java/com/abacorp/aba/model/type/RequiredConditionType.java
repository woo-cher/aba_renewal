package com.abacorp.aba.model.type;

import com.abacorp.aba.model.mapper.TypeMapper;
import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum RequiredConditionType implements TypeMapper {

    UNKNOWN("UNKNOWN"),

    /**
     * 거래 유형
     */
    TRANSPORT("대중교통"),
    PARKING("주차장"),
    ELEVATOR("엘리베이터"),
    DAYLIGHT("채광"),
    PET("반려동물"),
    FULL_OPTION("풀옵션"),
    CONVENIENCE_STORE("편의점"),
    NEW("신축"),
    STORAGE("수납"),
    TERRACE("테라스"),
    QUITE("조용한"),
    MIDDLE_HIGH_SCHOOL("중고등학교"),
    MANLESS_DELIVERY("무인택배함");

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
