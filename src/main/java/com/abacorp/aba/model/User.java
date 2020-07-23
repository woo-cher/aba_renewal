package com.abacorp.aba.model;

import com.abacorp.aba.model.mapper.ModelMapper;
import com.abacorp.aba.model.type.UserRoleType;
import com.abacorp.aba.model.type.UserType;
import lombok.*;

/**
 * @see UserRoleType
 * @see UserType
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
public class User extends ModelMapper {
    private String userId;
    private String password;
    private UserType type;
    private String name;
    private String nickName;
    private String email;
    private String phone;
    @Builder.Default
    private UserRoleType role = UserRoleType.USER;
    private String avatarUrl;
    private String jibunAddr;
    private String roadAddr;
    private String extraAddr;
    private String lastIp;
    private String agentName;
    private String agentNumber;
    private String agentPhone;
    private float latitude;
    private float longitude;
}
