package com.abacorp.aba.model.mapper;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.Builder;

import java.sql.Timestamp;

@Getter
@Setter
public class ModelMapper {
    protected int id;
    protected Timestamp createdAt;
    protected Timestamp updatedAt;
}
