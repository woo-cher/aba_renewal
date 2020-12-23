package com.abacorp.aba.model;

import com.abacorp.aba.model.mapper.ModelMapper;
import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Payment extends ModelMapper {
    private User user;
    private int amount;
    private String pg;
    private String method;
}
