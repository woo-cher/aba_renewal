package com.abacorp.aba.interfaces.strategy;

import com.abacorp.aba.model.mapper.ModelMapper;

import java.util.List;

public interface BasicQueryStrategy<M extends ModelMapper> {
    List<M> findAll();
    M selectById(Object id);
    int create(M model);
    int update(M model);
    int delete(M model);
}
