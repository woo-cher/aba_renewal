package com.abacorp.aba.model;

import lombok.*;

@Getter
@Setter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private int id;
    private String userId;
    private String password;
    private String name;
    private String nickName;
    private String residentNumber;
    private String email;
    private String phone;
    private String birth;
}
