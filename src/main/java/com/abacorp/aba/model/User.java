package com.abacorp.aba.model;

import com.abacorp.aba.model.mapper.ModelMapper;
import lombok.*;

@Getter
@Setter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class User extends ModelMapper {
    private String userId;
    private String password;
    private String name;
    private String nickName;
    private String residentNumber;
    private String email;
    private String phone;
    private String birth;
    private String role;
}
