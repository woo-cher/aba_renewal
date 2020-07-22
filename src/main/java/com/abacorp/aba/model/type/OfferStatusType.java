package com.abacorp.aba.model.type;

import com.abacorp.aba.model.mapper.TypeMapper;
import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum OfferStatusType implements TypeMapper {

    UNKNOWN("UNKNOWN"),

    /**
     * 거래 유형
     */
    ON("진행중"),
    OFF("미진행"),
    HIDE("숨김");

    private String value;

    OfferStatusType(String value) {
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
        return "OfferStatusType {" +
                "value='" + value + '\'' +
                '}';
    }
}