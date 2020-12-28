package com.abacorp.aba.model;

import com.abacorp.aba.model.mapper.ModelMapper;
import lombok.*;

import java.sql.Timestamp;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
public class Membership extends ModelMapper {
    private User user;
    private Package abaPackage;
    private Timestamp expiredAt;
}
