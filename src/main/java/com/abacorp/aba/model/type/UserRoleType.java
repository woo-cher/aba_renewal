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

    private String name;

    UserRoleType(String name) {
        this.name = name;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public String getCode() {
        return name();
    }

    @Override
    public String toString() {
        return "PropertyType{" +
                "name='" + name + '\'' +
                '}';
    }
}
