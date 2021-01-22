package com.abacorp.aba.model;

import com.abacorp.aba.model.mapper.ModelMapper;
import lombok.*;

import java.sql.Timestamp;

@Data
@Builder
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Membership extends ModelMapper {
    private User user;
    private Product product;
    private Timestamp expiredAt;
}
