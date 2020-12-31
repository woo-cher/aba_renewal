package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.Product;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
@Slf4j
public class ProductRepository {

    @Autowired
    private SqlSession sqlSession;

    public Product selectProductById(int id) {
        return sqlSession.selectOne("selectProductById", id);
    }
}
