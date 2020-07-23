package com.abacorp.aba.model.type;

import com.abacorp.aba.model.mapper.TypeMapper;
import com.abacorp.aba.security.CustomUserDetails;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum UserRoleType implements TypeMapper {

    /**
     * 유저 권한
     */
    UNKNOWN("UNKNOWN"),

    MASTER("대표"),
    ADMIN("관리자"),
    USER("일반사용자"),
    PREMIUM("유료사용자"),

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
        return CustomUserDetails.ROLE_PREFIX + name();
    }

    @JsonCreator
    public static UserRoleType create(String code) {
        for (UserRoleType userType : values()) {
            if (userType.equals(UserRoleType.valueOf(code))) {
                return userType;
            }
        }
        return UNKNOWN;
    }

    @Override
    public String toString() {
        return "UserRoleType {" +
                "code='" + getCode() + '\'' +
                "value='" + value + '\'' +
                '}';
    }
}
