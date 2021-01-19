package com.abacorp.aba.model.type;

import com.abacorp.aba.model.mapper.TypeMapper;
import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum HeatingMethodType implements TypeMapper {

    UNKNOWN("UNKNOWN"),

    /**
     * 난방 방식
     */
    INDIVIDUAL("개별난방"),
    CENTERAL("중앙난방"),
    LOCAL("지역난방");

    private String value;

    HeatingMethodType(String value) {
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

    public static HeatingMethodType createWhenContainsValue(String value) {
        if (value.equals("") || value.equals("기타"))
            return null;
        for (HeatingMethodType method : values()) {
            if (value.contains(method.getValue())) {
                return method;
            }
        }
        return UNKNOWN;
    }

    @Override
    public String toString() {
        return "HeatingMethodType {" +
                "value='" + value + '\'' +
                '}';
    }
}
