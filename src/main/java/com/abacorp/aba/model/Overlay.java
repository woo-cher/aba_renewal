package com.abacorp.aba.model;

import com.abacorp.aba.model.mapper.ModelMapper;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Overlay extends ModelMapper {
    private static final Logger logger = LoggerFactory.getLogger(Overlay.class);
    private int count;
    private int weight;
    private float centerX;
    private float centerY;
    private String coordinates;
    private String name;
    private String belongs;
}
