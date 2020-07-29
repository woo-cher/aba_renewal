package com.abacorp.aba.model.mapper;

import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;

@Getter
@Setter
public class ModelMapper {
    protected int id;
    protected Timestamp createdAt;
    protected Timestamp updatedAt;
}
