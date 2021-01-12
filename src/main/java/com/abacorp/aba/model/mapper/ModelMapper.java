package com.abacorp.aba.model.mapper;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

import java.sql.Timestamp;

@SuperBuilder
@Getter
@Setter
public class ModelMapper {
    protected int id;
    protected Timestamp createdAt;
    protected Timestamp updatedAt;
}
