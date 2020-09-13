package com.abacorp.aba.model.type;

import com.abacorp.aba.model.mapper.TypeMapper;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum OfferRequestType implements TypeMapper {

    UNKNOWN("UNKNOWN"),

    /**
     * 유저 권한
     */
    VILLA("빌라"),
    APARTMENT("아파트"),
    OFFICE("오피스텔"),
    HOUSING("주택");

    private String value;

    OfferRequestType(String value) {
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
    public static OfferRequestType create(String code) {
        for (OfferRequestType reqType : values()) {
            if (reqType.getCode().equals(code)) {
                return reqType;
            }
        }
        return UNKNOWN;
    }

    @Override
    public String toString() {
        return "OfferRequestType {" +
                "value='" + value + '\'' +
                '}';
    }
}
