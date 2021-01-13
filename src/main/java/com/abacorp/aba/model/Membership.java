package com.abacorp.aba.model;

import com.abacorp.aba.model.mapper.ModelMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import lombok.Builder;

import java.sql.Timestamp;

@Data
@Builder
@EqualsAndHashCode
@ToString
public class Membership extends ModelMapper {
    private User user;
    private Product product;
    private Timestamp expiredAt;
}
