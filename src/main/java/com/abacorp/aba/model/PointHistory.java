package com.abacorp.aba.model;

import com.abacorp.aba.model.mapper.ModelMapper;
import lombok.Data;
import lombok.ToString;
import lombok.Builder;

@Data
@Builder
@ToString
public class PointHistory extends ModelMapper {
    private User user;
    private Product product;
}
