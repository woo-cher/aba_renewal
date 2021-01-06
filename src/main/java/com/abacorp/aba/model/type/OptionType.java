package com.abacorp.aba.model.type;

import com.abacorp.aba.model.mapper.TypeMapper;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum OptionType implements TypeMapper {

    UNKNOWN("UNKNOWN"),

    /**
     * 거래 유형
     */
    AIR_CONDITIONER("에어컨"),
    WASHING("세탁기"),
    REFRIGERATOR("냉장고"),
    GAS_STOVE("가스렌지"),
    INDUCTION("인덕션"),
    MICROWAVE("전자렌지"),
    TV("TV"),
    BED("침대"),
    CLOSET("붙박이장"),
    TABLE("책상"),
    SHOE_RACK("신발장"),
    DOOR_LOCK("도어락");

    private String value;

    OptionType(String value) {
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
    public static OptionType createWithValue(String value) {
        for (OptionType optionType : values()) {
            if (optionType.getValue().equals(value)) {
                return optionType;
            }
        }
        return UNKNOWN;
    }

    @Override
    public String toString() {
        return "OptionType {" +
                "value='" + value + '\'' +
                '}';
    }
}
