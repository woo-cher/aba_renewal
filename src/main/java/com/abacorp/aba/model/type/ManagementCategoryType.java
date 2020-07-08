package com.abacorp.aba.model.type;

import com.abacorp.aba.model.mapper.TypeMapper;
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
    INDUCTION("엘리베이터");

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

    @Override
    public String toString() {
        return "ManagementCategoryType {" +
                "value='" + value + '\'' +
                '}';
    }
}
