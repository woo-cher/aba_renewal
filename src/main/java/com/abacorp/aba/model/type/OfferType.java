package com.abacorp.aba.model.type;

import com.abacorp.aba.model.mapper.TypeMapper;
import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum OfferType implements TypeMapper {

    /**
     * 유저 권한
     */
    ONE_ROOM("원룸"),
    TWO_THREE_ROOM("투룸"),
    EFFICIENCY_APT("오피스텔"),
    APT("아파트"),
    SHOP("상가"),
    HOUSING("주택"),
    OFFICE("사무실"),
    LAND("사무실"),
    BUILDING("건물"),

    UNKNOWN("UNKNOWN");

    private String value;

    OfferType(String value) {
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
        return "OfferType {" +
                "value='" + value + '\'' +
                '}';
    }
}
