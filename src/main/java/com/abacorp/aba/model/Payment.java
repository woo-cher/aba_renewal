package com.abacorp.aba.model;

import com.abacorp.aba.model.mapper.ModelMapper;
import lombok.Data;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@Data
@SuperBuilder
@ToString
public class Payment extends ModelMapper {
    private String impId;
    private String merchantId;
    private User user;
    private int amount;
    private String pg;
    private String method;
}
