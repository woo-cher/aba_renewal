package com.abacorp.aba.model.type;

import com.abacorp.aba.model.mapper.TypeMapper;
import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum HeatingType implements TypeMapper {

    UNKNOWN("정보없음"),

    /**
     * 난방유형
     */
    GAS("도시가스"),
    LPG("엘피지(LPG)"),
    OIL("기름보일러"),
    ELECT("심야전기"),
    PANEL("판넬");

    private String value;

    HeatingType(String value) {
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

    public static HeatingType createWhenContainsValue(String value) {
        if (value.equals("") || value.equals("기타"))
            return null;
        for (HeatingType heatingType : values()) {
            if (heatingType.getValue().contains(value)) {
                return heatingType;
            }
        }
        return UNKNOWN;
    }

    @Override
    public String toString() {
        return "HeatingType {" +
                "value='" + value + '\'' +
                '}';
    }
}
