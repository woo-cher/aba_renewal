package com.abacorp.aba.model.type;

import com.abacorp.aba.model.mapper.TypeMapper;
import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum UserRoleType implements TypeMapper {

    /**
     * 유저 권한
     */
    ADMIN("ADMIN"),
    USER("USER"),

    ANONYMOUS("ANONYMOUS");

    private String value;

    UserRoleType(String value) {
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
        return "PropertyType {" +
                "value='" + value + '\'' +
                '}';
    }
}
