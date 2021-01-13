package com.abacorp.aba.model;

import com.abacorp.aba.model.mapper.ModelMapper;
import lombok.*;
import lombok.Builder;

@Data
@Builder
@ToString
public class Overlay extends ModelMapper {
    private int count;
    private int weight;
    private float latitude;
    private float longitude;
    private String coordinates;
    private String name;
    private String belongsTo;
}
