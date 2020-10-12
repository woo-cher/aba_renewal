package com.abacorp.aba.model;

import com.abacorp.aba.model.type.UserRoleType;
import com.abacorp.aba.model.type.UserType;
import lombok.*;

/**
 * @see com.abacorp.aba.model.mapper.ModelMapper
 *
 * NOTE>
 *  User 클래스의 경우 Primary key 가 `userId` 이므로, 상속하지 않음
 *  상속을 하게 되면, mybatis argument mismatch 에러 발생 이슈
 *
 * @see UserRoleType
 * @see UserType
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
public class User {
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
    private String agentLeader;
    private float locationX;
    private float locationY;
}
