package com.abacorp.aba.model.type;

import com.abacorp.aba.model.mapper.TypeMapper;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum ManagementCategoryType implements TypeMapper {

    UNKNOWN("UNKNOWN"),

    /**
     * 거래 유형
     */
    AIR_CONDITIONER("수도세"),
    WASHING("인터넷"),
    REFRIGERATOR("유선방송"),
    GAS_STOVE("셋톱박스"),
    ELEVATOR("엘리베이터"),
    CLEANING("건물청소비"),
    COMMON_POWER("공용전기");

    private String value;

    ManagementCategoryType(String value) {
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
    public static ManagementCategoryType createWithValue(String value) {
        for (ManagementCategoryType category : values()) {
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
