package com.abacorp.aba.model.type;

import com.abacorp.aba.model.mapper.TypeMapper;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum FacilityCostCategoryType implements TypeMapper {

    UNKNOWN("UNKNOWN"),

    /**
     * 거래 유형
     */
    INTERIOR("인테리어비용"),
    AIRCONDITIONER("에어컨"),
    TABLEWARE("식기구"),
    OTHERTEHN("기타");

    private String value;

    FacilityCostCategoryType(String value) {
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
    public static FacilityCostCategoryType createWithValue(String value) {
        for (FacilityCostCategoryType category : values()) {
            if (category.getValue().equals(value)) {
                return category;
            }
        }
        return UNKNOWN;
    }

    @Override
    public String toString() {
        return "ManagementCategoryType {" +
                "value='" + value + '\'' +
                '}';
    }
}
