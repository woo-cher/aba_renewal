package com.abacorp.aba.model.type;

import com.abacorp.aba.model.mapper.TypeMapper;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum UserType implements TypeMapper {

    UNKNOWN("UNKNOWN"),

    MASTER("관리자"),
    OWNER("집주인"),
    ASSISTANT("중개보조원"),
    BROKER("공인중개사");

    private String value;

    UserType(String value) {
        this.value = value;
    }

    @Override
    public String getCode() {
        return name();
    }

    @Override
    public String getValue() {
        return value;
    }

    @JsonCreator
    public static UserType create(String code) {
        for (UserType userType : values()) {
            if (userType.equals(UserType.valueOf(code))) {
                return userType;
            }
        }
        return UNKNOWN;
    }

    @Override
    public String toString() {
        return "UserType {" +
                "code='" + getCode() + '\'' +
                "value='" + value + '\'' +
                '}';
    }
}
