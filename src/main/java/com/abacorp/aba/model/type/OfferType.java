package com.abacorp.aba.model.type;

import com.abacorp.aba.model.mapper.TypeMapper;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.extern.slf4j.Slf4j;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
@Slf4j
public enum OfferType implements TypeMapper {

    UNKNOWN("UNKNOWN"),

    /**
     * 유저 권한
     */
    ONE_ROOM("원룸"),
    TWO_THREE_ROOM("투∙쓰리룸"),
    EFFICIENCY_APT("오피스텔"),
    APT("아파트"),
    SHOP("상가"),
    HOUSING("주택"),
    OFFICE("사무실"),
    BUILDING("건물"),
    LAND("토지");

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

    @JsonCreator
    public static OfferType create(String code) {
        for (OfferType offerType : values()) {
            if (offerType.getCode().equals(code)) {
                return offerType;
            }
        }
        return UNKNOWN;
    }

    public static OfferType createWhenContainsValue(String value) {
        if (value.equals("")) {
            return null;
        } else if (value.contains("건물/")) {
            value = value.replace("건물/", "");
        } else if (value.equals("투∙쓰리룸")) {
            return TWO_THREE_ROOM;
        }
        for (OfferType offerType : values()) {
            if (value.contains(offerType.getValue())) {
                return offerType;
            }
        }
        return UNKNOWN;
    }

    @Override
    public String toString() {
        return "OfferType {" +
                "value='" + value + '\'' +
                '}';
    }
}
