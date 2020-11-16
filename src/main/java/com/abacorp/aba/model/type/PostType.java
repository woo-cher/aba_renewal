package com.abacorp.aba.model.type;

import com.abacorp.aba.model.mapper.TypeMapper;
import com.abacorp.aba.security.CustomUserDetails;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum PostType implements TypeMapper {

    /**
     * 게시글 유형
     */
    UNKNOWN("UNKNOWN"),

    NOTICE("공지"),
    NORMAL("일반게시물");

    private String value;

    PostType(String value) {
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
    public static PostType create(String code) {
        for (PostType postType : values()) {
            if (postType.equals(UserRoleType.valueOf(code))) {
                return postType;
            }
        }
        return UNKNOWN;
    }

    @Override
    public String toString() {
        return "PostType {" +
                "code='" + getCode() + '\'' +
                "value='" + value + '\'' +
                '}';
    }
}
