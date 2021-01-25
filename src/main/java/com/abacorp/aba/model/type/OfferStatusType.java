package com.abacorp.aba.model.type;

import com.abacorp.aba.model.mapper.TypeMapper;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.extern.slf4j.Slf4j;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
@Slf4j
public enum OfferStatusType implements TypeMapper {

    UNKNOWN("UNKNOWN"),

    /**
     * 거래 유형
     */
    ON("진행중"),
    OFF("계약완료"),
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

    @JsonCreator
    public static OfferStatusType create(String code) {
        for (OfferStatusType statusType : values()) {
            if (statusType.getCode().equals(code)) {
                return statusType;
            }
        }

        return UNKNOWN;
    }

    public static OfferStatusType createWhenContainsValue(String value) {
        if (value.equals(""))
            return null;
        for (OfferStatusType statusType : values()) {
            if (value.contains(statusType.getValue())) {
                return statusType;
            }
        }
        return UNKNOWN;
    }

    @Override
    public String toString() {
        return "OfferStatusType {" +
                "value='" + value + '\'' +
                '}';
    }
}
